part of 'pages.dart';

class DetailMovie extends StatefulWidget {
  final String movieId;

  const DetailMovie({Key key, this.movieId}) : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  Movie movie = new Movie(judul: "", tanggal: "" );
  Movie fbMovie = new Movie( timestamp: "", notes: "" );
  String judulCard = "";
  List<String> genreList = [];
  String genreCard = "";
  bool isFavorite = false;
  IconData iconFavorite = Icons.favorite_outline;
  String type = "movie#";

  // Untuk menu
  List<String> categories = ["Progress", "Information", "Friends"];
  List<IconData> categories_icon = [
    Icons.bar_chart,
    Icons.info_outlined,
    Icons.people_outlined
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ApiServices.getMovieDetail(widget.movieId).then((value) => {
          setState(() {
            movie = new Movie(
              id: value.id,
              judul: value.judul,
              overview: value.overview,
              backdrop: value.backdrop,
              tanggal: value.tanggal,
              genreIds: value.genreIds,
            );
            judulCard = movie.judul + " (";
            judulCard += movie.tanggal.substring(0, 4);
            judulCard += ")";
          })
        });
    ApiServices.getGenres(movie.genreIds).then((value) => {
          setState(() {
            // genreList = value;
            // for (int i = 0; i < genreList.length; i++) {
            genreCard = value;
            // print("DEBUG 2");
            // print(genreList);
            // }
          })
        });

    String uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference productCollection = FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection(type + movie.id);

    productCollection.get().then((value) {
      value.docs.forEach((element) {
        fbMovie.timestamp = element["timestamp"];
        fbMovie.notes = element["notes"];
      });
      if (value.docs.length == 0) {
        fbMovie.timestamp = "00:00:00";
        fbMovie.notes = "No notes added!";
      }
    });

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Movie Detail",
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
                        builder: (context) => NontonMovie(
                            movieId: movie.id, movieJudul: movie.judul))),
              },
              color: filmophileBlue,
            ),
            IconButton(
              icon: Icon(iconFavorite),
              onPressed: () => {
                isFavorite = !isFavorite,
                if (isFavorite)
                  {iconFavorite = Icons.favorite}
                else
                  {iconFavorite = Icons.favorite_outline},
                setState(() {}),
                print(isFavorite)
              },
              color: filmophileOrange,
            )
          ]),
      body: Column(
        children: [
          (movie != null)
              ? Stack(
                  children: [
                    // Kalau ada datanya
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 11 / 18,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              Constant.IMAGE_BASE_URL + movie.backdrop,
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
                          top: (MediaQuery.of(context).size.width * 11 / 18) -
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
                              margin:
                                  EdgeInsets.only(top: 12, left: 12, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    judulCard,
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.righteous().fontFamily,
                                      fontSize: 28,
                                      color: filmophileBlue,
                                    ),
                                  ),
                                  Text(
                                    genreCard,
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.rhodiumLibre().fontFamily,
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
              : Text("Loading...")
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
                fbMovie.timestamp,
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
                fbMovie.notes,
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
              movie.overview,
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
                  // margin: EdgeInsets.only(top: 5),
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
          // Container(
          //   alignment: Alignment.center,
          //   height: 4,
          //   width: 50,
          //   color:
          //       selectedIndex == index ? filmophileOrange : Colors.transparent,
          // ),
        ],
      ),
    );
  }
}
