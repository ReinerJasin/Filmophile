part of 'pages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Untuk API
  List<Media> listMedia = [];

  //Untuk menu kategori
  List<String> categories = ["Movie", "TV Show"];
  List<String> category = ["movie", "tv"];
  List<String> category_filter = ["movie#", "tvshow#"];
  List<String> ranks = ["Bronze", "Silver", "Gold", "Platinum", "Filmophile"];
  int selectedIndex = 0;

  String type;
  Movie fbMovie;

  //untuk menyesuaikan layar dengan gridview
  double gridViewResolution = 0.6666666667;

  Users currentUser;

  int refresh = 0;

  @override

  // String nameCurrent = FirebaseAuth.instance.currentUser.;

  Widget build(BuildContext context) {
    // print(" MANTAP");
    UserService.getCurrentUser().then((value) {
      // print(value.name + " MANTAP");
      currentUser = new Users("", value.profilePicture, value.name, "", "", "",
          "", "", "", value.following, value.followers, value.rank);
      if (currentUser != null && refresh == 0) {
        (context as Element).markNeedsBuild();
        refresh = 1;
      }
    });
    // UserService.getCurrentUser();
    // print(currentUser.name + "MANTAP");

    setState(() {
      ApiServices.getMediaList(category[selectedIndex]).then((medias) => {
            listMedia = medias,
          });
    });
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 36),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7 - 12,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 36),
                      Text(
                        (currentUser.name != null)
                            ? currentUser.name
                            : "Loading...",
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          color: filmophileBlue,
                          fontFamily: GoogleFonts.righteous().fontFamily,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Row(
                        children: [
                          Text(
                            (ranks[int.parse(currentUser.rank) - 1] != null)
                                ? ranks[int.parse(currentUser.rank) - 1]
                                : "",
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(width: 8),
                          for (int i = 0; i < int.parse(currentUser.rank); i++)
                            Icon(
                              Icons.whatshot_outlined,
                              color: filmophileOrange,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.3 - 12,
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 70,
                    color: filmophileBlue,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: filmophileSoftBlue,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                style: TextStyle(
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                      color: filmophileBlue),
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                      color: filmophileBlue),
                  icon: Icon(
                    Icons.search,
                    color: filmophileBlue,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => buildCategory(index),
              ),
            ),
            FutureBuilder(
              future: ApiServices.getMediaList(category[selectedIndex]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: gridViewResolution,
                      ),
                      itemBuilder: (context, index) => MediaCard(
                        media: listMedia[index],
                        type: category_filter[selectedIndex],
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    (category[selectedIndex] == "movie")
                                        ? DetailMovie(
                                            movieId: listMedia[index].id)
                                        : DetailTv(tvId: listMedia[index].id))),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          // (context as Element).markNeedsBuild();
        });
      },
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              categories[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: filmophileBlue,
                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 4,
            width: 50,
            color:
                selectedIndex == index ? filmophileOrange : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
