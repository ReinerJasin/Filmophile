part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;

  // Untuk API
  List<Media> listMedia = [];

  //Untuk menu kategori
  List<String> categories = ["My Movie", "My TV Show"];
  List<String> category = ["movie", "tv"];
  List<String> category_filter = ["movie#", "tvshow#"];
  List<String> ranks = ["BRONZE", "SILVER", "GOLD", "PLATINUM", "FILMOPHILE"];
  int selectedIndex = 0;

  String type;
  Movie fbMovie;

  //untuk menyesuaikan layar dengan gridview
  double gridViewResolution = 0.6666666667;

  Users currentUser;

  int refresh = 0;

  @override
  Widget build(BuildContext context) {
    print(" MANTAP");
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
    print(currentUser.following + "MANTAP");

    setState(() {
      ApiServices.getMediaList(category[selectedIndex]).then((medias) => {
            listMedia = medias,
          });
    });

    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 36),
          child: Column(
            children: [
              Column(
                children: [
                  // SizedBox(
                  //   width: 12,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.7 - 12,
                  //   height: 70,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // SizedBox(height: 36),
                  //       Text(
                  //         (currentUser.name != null)
                  //             ? currentUser.name
                  //             : "Loading...",
                  //         maxLines: 1,
                  //         overflow: TextOverflow.fade,
                  //         softWrap: false,
                  //         style: TextStyle(
                  //           color: filmophileBlue,
                  //           fontFamily: GoogleFonts.righteous().fontFamily,
                  //           fontSize: 25,
                  //         ),
                  //         textAlign: TextAlign.right,
                  //       ),
                  //       Row(
                  //         children: [
                  //           Text(
                  //             (ranks[int.parse(currentUser.rank) - 1] != null)
                  //                 ? ranks[int.parse(currentUser.rank) - 1]
                  //                 : "",
                  //             style: TextStyle(
                  //               color: filmophileBlue,
                  //               fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                  //               fontSize: 18,
                  //             ),
                  //             textAlign: TextAlign.right,
                  //           ),
                  //           SizedBox(width: 8),
                  //           for (int i = 0; i < int.parse(currentUser.rank); i++)
                  //             Icon(
                  //               Icons.whatshot_outlined,
                  //               color: filmophileOrange,
                  //             ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: MediaQuery.of(context).size.width * 0.3,
                      color: filmophileBlue,
                    ),
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Column(
                      //   children: [
                      //     Text(
                      //       "Friends",
                      //       style: TextStyle(
                      //         color: filmophileBlue,
                      //         fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //     Text("350",
                      //       style: TextStyle(
                      //         color: filmophileBlue,
                      //         fontFamily: GoogleFonts.righteous().fontFamily,
                      //         fontSize: 25,
                      //       ),),
                      //   ],
                      // ),
                      Column(
                        children: [
                          Text(
                            "Following",
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            currentUser.following,
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.righteous().fontFamily,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Followers",
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            currentUser.followers,
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.righteous().fontFamily,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                                          : DetailTv(
                                              tvId: listMedia[index].id))),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 36, right: 8),
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Text(
              "Log Out",
              style: TextStyle(
                fontFamily: GoogleFonts.righteous().fontFamily,
                color: filmophileOrange,
                fontSize: 18,
              ),
            ),
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await AuthServices.signOut().then((value) {
                if (value == true) {
                  setState(() {
                    isLoading = false;
                  });
                  ActivityServices.showToast("Logout success", Colors.green);
                  Navigator.pushReplacementNamed(context, Login.routeName);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ActivityServices.showToast("Logout failed", Colors.red);
                }
              });
            },
          ),
        ),
        isLoading == true ? ActivityServices.loadings() : Container()
      ]),
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
