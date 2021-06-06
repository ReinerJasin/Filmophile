part of 'pages.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Untuk API
  List<Media> listMedia = [];

  //Untuk menu kategori
  List<String> categories = ["Movie", "TV Show"];
  List<String> category = ["movie", "tv"];
  List<String> category_filter = ["movie#", "tvshow#"];
  int selectedIndex = 0;
  List<String> categoriesMovie = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Music",
    "Mystery",
    "Romance",
    "Science Fiction",
    "TV Movie",
    "Thriller",
    "War",
    "Western"
  ];
  List<String> categoryMovie = [
    "28",
    "12",
    "16",
    "35",
    "80",
    "99",
    "18",
    "10751",
    "14",
    "36",
    "27",
    "10402",
    "9648",
    "10749",
    "878",
    "10770",
    "53",
    "10752",
    "37"
  ];
  int selectedIndexMovie = 0;
  List<String> categoriesTv = [
    "Action & Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Kids",
    "Mystery",
    "News",
    "Reality",
    "Sci-Fi & Fantasy",
    "Soap",
    "Talk",
    "War & Politics",
    "Western"
  ];
  List<String> categoryTv = [
    "10759",
    "16",
    "35",
    "80",
    "99",
    "18",
    "10751",
    "10762",
    "9648",
    "10763",
    "10764",
    "10765",
    "10766",
    "10767",
    "10768",
    "37"
  ];
  int selectedIndexTv = 0;

  String type;
  Movie fbMovie;

  double gridViewResolution = 0.6666666667;

  Users currentUser;

  int refresh = 0;

  @override
  Widget build(BuildContext context) {
    UserService.getCurrentUser().then((value) {
      currentUser = new Users("", value.profilePicture, value.name, "", "", "",
          "", "", "", value.following, value.followers, value.rank);
      if (currentUser != null && refresh == 0) {
        (context as Element).markNeedsBuild();
        refresh = 1;
      }
    });

    setState(() {
      if (category[selectedIndex] == "movie") {
        ApiServices.getMediaListExplore(
                category[selectedIndex], categoryMovie[selectedIndexMovie])
            .then((medias) => {
                  listMedia = medias,
                });
        print("masuk di movie");
        print("genre nya " + categoryMovie[selectedIndexMovie]);
      } else {
        ApiServices.getMediaListExplore(
                category[selectedIndex], categoryTv[selectedIndexTv])
            .then((medias) => {
                  listMedia = medias,
                });
        print("masuk di TV");
        print("genre nya " + categoryTv[selectedIndexTv]);
      }
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 36),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => buildCategory(index),
              ),
            ),
            (selectedIndex == 0)
                ? SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesMovie.length,
                      itemBuilder: (context, index) =>
                          buildCategoryMovie(index),
                    ),
                  )
                : SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesTv.length,
                      itemBuilder: (context, index) =>
                          buildCategoryTvShow(index),
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

  Widget buildCategoryMovie(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndexMovie = index;
        });
        print(index.toString());
      },
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              categoriesMovie[index],
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
            color: selectedIndexMovie == index
                ? filmophileOrange
                : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget buildCategoryTvShow(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndexTv = index;
        });
      },
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              categoriesTv[index],
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
            color: selectedIndexTv == index
                ? filmophileOrange
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
