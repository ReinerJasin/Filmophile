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
      // appBar: new AppBar(
      //   title: Text('Users'),
      // ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 24,
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
                                    DetailMovie(movieId: listMedia[index].id))),
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
            margin: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              categories[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff015571),
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
                selectedIndex == index ? Color(0xffE6614C) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
