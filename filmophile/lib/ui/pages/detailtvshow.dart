part of 'pages.dart';

class DetailTv extends StatefulWidget {
  final String tvId;

  const DetailTv({Key key, this.tvId}) : super(key: key);
  @override
  _DetailTvState createState() => _DetailTvState();
}

class _DetailTvState extends State<DetailTv> {
  TvShow tvShow = new TvShow(judul: "", tanggal: "");
  TvShow fbTvShow =
      new TvShow(timestamp: "", notes: "", episode: "0", season: "0");
  String judulCard = "";
  List<String> genreList = [];
  String genreCard = "";
  String isFavorite = "false";
  IconData iconFavorite = Icons.favorite_outline;
  String type = "tvshow#";

  // Untuk menu
  List<String> categories = ["Progress", "Information", "Friends"];
  List<IconData> categories_icon = [
    Icons.bar_chart,
    Icons.info_outlined,
    Icons.people_outlined
  ];
  int selectedIndex = 0;

  bool isLoading = true;
  String newTV = "false";

  @override
  Widget build(BuildContext context) {
    ApiServices.getTvShowDetail(widget.tvId).then((value) => {
          setState(() {
            tvShow = new TvShow(
              id: value.id,
              judul: value.judul,
              overview: value.overview,
              backdrop: value.backdrop,
              tanggal: value.tanggal,
              season: value.season,
              episode: value.episode,
              genreIds: value.genreIds,
            );
            judulCard = tvShow.judul + " (";
            judulCard += tvShow.tanggal.substring(0, 4);
            judulCard += ")";
          })
        });
    ApiServices.getGenres(tvShow.genreIds).then((value) => {
          setState(() {
            genreCard = value;
          })
        });

    String uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference productCollection = FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection(type + tvShow.id);

    productCollection.get().then((value) {
      value.docs.forEach((element) {
        fbTvShow.status = element["status"];
        fbTvShow.season = element["current_season"];
        fbTvShow.episode = element["current_episode"];
        fbTvShow.timestamp = element["timestamp"];
        fbTvShow.notes = element["notes"];
      });
      if (value.docs.length == 0) {
        fbTvShow.status = "Not Watched";
        fbTvShow.season = "0";
        fbTvShow.episode = "0";
        fbTvShow.timestamp = "00:00:00";
        fbTvShow.notes = "No notes added!";
        newTV = "true";
      }
      isLoading = false;
    });

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "TV Show Detail",
            style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.righteous().fontFamily),
          ),
          iconTheme: IconThemeData(color: filmophileBlue),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.create),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NontonTv(
                              tvId: tvShow.id,
                              tvJudul: tvShow.judul,
                              maxSeason: tvShow.season,
                              maxEpisode: tvShow.episode,
                              status: fbTvShow.status,
                              season: fbTvShow.season,
                              episode: fbTvShow.episode,
                              timestamp: fbTvShow.timestamp,
                              notes: fbTvShow.notes,
                              newTV: newTV,
                            ))),
              },
              color: filmophileBlue,
            ),
            IconButton(
              icon: Icon(iconFavorite),
              onPressed: () => {
                print("is fave = " + isFavorite),
                if (isFavorite == "false")
                  {
                    isFavorite = "true",
                    iconFavorite = Icons.favorite,
                    MediaServices.changeFavorite(
                        uid, tvShow.id, type, isFavorite),
                  }
                else
                  {
                    isFavorite = "false",
                    iconFavorite = Icons.favorite_outline,
                    MediaServices.changeFavorite(
                        uid, tvShow.id, type, isFavorite),
                  },
                setState(() {}),
                print(isFavorite)
              },
              color: filmophileOrange,
            )
          ]),
      body: Stack(
        children: [
          Column(
            children: [
              (tvShow != null)
                  ? Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 11 / 18,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  Constant.IMAGE_BASE_URL + tvShow.backdrop,
                                ),
                                fit: BoxFit.cover),
                            color: filmophileSoftBlue,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 11 / 18,
                          decoration: BoxDecoration(
                            color: filmophileSoftBlue,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.width * 11 / 18) -
                              80 +
                              20,
                          margin: EdgeInsets.only(
                              top: (MediaQuery.of(context).size.width *
                                      11 /
                                      18) -
                                  20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Container(
                            child: ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 12, left: 12, right: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        judulCard,
                                        style: TextStyle(
                                          fontFamily: GoogleFonts.righteous()
                                              .fontFamily,
                                          fontSize: 28,
                                          color: filmophileBlue,
                                        ),
                                      ),
                                      Text(
                                        genreCard,
                                        style: TextStyle(
                                          fontFamily: GoogleFonts.rhodiumLibre()
                                              .fontFamily,
                                          fontSize: 18,
                                          color: filmophileBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) =>
                                        buildCategory(index),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: buildMenu(selectedIndex),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Text("nd ada data")
            ],
          ),
          isLoading == true ? ActivityServices.loadings() : Container()
        ],
      ),
    );
  }

  Container buildMenu(int index) {
    // PROGRESS MENU
    if (index == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progress",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // SEASON PROGRESS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      fbTvShow.season + "/" + tvShow.season,
                      style: TextStyle(
                        color: filmophileBlue,
                        fontFamily: GoogleFonts.righteous().fontFamily,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      " Season(s) ",
                      style: TextStyle(
                        color: filmophileBlue,
                        fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    (int.parse(fbTvShow.season) /
                                int.parse(tvShow.season) *
                                100)
                            .round()
                            .toString() +
                        "%",
                    style: TextStyle(
                      color: filmophileBlue,
                      fontFamily: GoogleFonts.righteous().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: filmophileGrey,
                  ),
                ),
                Container(
                  height: 8,
                  width: MediaQuery.of(context).size.width *
                      int.parse(fbTvShow.season) /
                      int.parse(tvShow.season),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: filmophileOrange,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 12,
            ),

            // EPISODE PROGRESS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      fbTvShow.episode + "/" + tvShow.episode,
                      style: TextStyle(
                        color: filmophileBlue,
                        fontFamily: GoogleFonts.righteous().fontFamily,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      " Episode(s) ",
                      style: TextStyle(
                        color: filmophileBlue,
                        fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    (int.parse(fbTvShow.episode) /
                                int.parse(tvShow.episode) *
                                100)
                            .round()
                            .toString() +
                        "%",
                    style: TextStyle(
                      color: filmophileBlue,
                      fontFamily: GoogleFonts.righteous().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: filmophileGrey,
                  ),
                ),
                Container(
                  height: 8,
                  width: MediaQuery.of(context).size.width *
                      int.parse(fbTvShow.episode) /
                      int.parse(tvShow.episode),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: filmophileOrange,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 16,
            ),

            Text(
              "Timestamp",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: Text(
                fbTvShow.timestamp,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GoogleFonts.righteous().fontFamily,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: filmophileBlue,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Notes",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: Text(
                fbTvShow.notes,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: filmophileBlue,
              ),
            ),
          ],
        ),
      );
    } else if (index == 1) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Information",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Description",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              tvShow.overview,
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              "Cast",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Friends who's waching",
              style: TextStyle(
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        children: [
          (selectedIndex == index)
              ? Container(
                  color: Colors.transparent,
                  // margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width * 0.333333,
                  child: Column(
                    children: [
                      Icon(
                        categories_icon[index],
                        color: filmophileOrange,
                      ),
                      Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: filmophileOrange,
                          fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.333333,
                  child: Column(
                    children: [
                      Icon(
                        categories_icon[index],
                        color: filmophileBlue,
                      ),
                      Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: filmophileBlue,
                          fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
