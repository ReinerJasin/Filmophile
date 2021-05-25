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
  int selectedIndex = 0;

  //untuk menyesuaikan layar dengan gridview
  // double gridViewResolution = 0.67665;
  double gridViewResolution = 0.6666666667;

  @override
  Widget build(BuildContext context) {
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
                        "ReinerJasin",
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
                            "Filmophile",
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.whatshot_outlined,
                            color: filmophileOrange,
                          ),
                          Icon(
                            Icons.whatshot_outlined,
                            color: filmophileOrange,
                          ),
                          Icon(
                            Icons.whatshot_outlined,
                            color: filmophileOrange,
                          ),
                          Icon(
                            Icons.whatshot_outlined,
                            color: filmophileOrange,
                          ),
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
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => buildCategory(index),
              ),
            ),
            FutureBuilder(
              future: ApiServices.getMediaList(category[selectedIndex])
              // .then((movies) {
              //   // print("HEY IT'S WORKING");
              //   listMovie = movies;
              //   setState(() {});
              // }
              // )
              ,
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
