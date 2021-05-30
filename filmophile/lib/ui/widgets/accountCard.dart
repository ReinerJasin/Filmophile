part of 'widgets.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final String rank;
  final String movie;
  final String episode;
  final String following;
  final String followers;
  final String index;

  const AccountCard(
      {Key key,
      this.name,
      this.rank,
      this.movie,
      this.episode,
      this.following,
      this.followers,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("HELLOOOO");
    List<IconData> addFriend = [
      Icons.person_add_outlined,
      Icons.how_to_reg_outlined
    ];
    List<Color> addFriendColor = [Colors.white, Color(0xFFB9D660)];

  List<String> listRank = ["BRONZE", "SILVER", "GOLD", "PLATINUM", "FILMOPHILE"];
    // String uid = FirebaseAuth.instance.currentUser.uid;
    // CollectionReference productCollection = FirebaseFirestore.instance
    //     .collection("watchlists")
    //     .doc(uid)
    //     .collection(type+ media.id);

    // productCollection.get().then((value) {
    //   value.docs.forEach((element) {
    //     if (media.id == element["mediaId"]) {
    //       media.timestamp = element["timestamp"];
    //     }

    // (context as Element).markNeedsBuild();
    //   });
    // });

    // (context as Element).markNeedsBuild();

    return GestureDetector(
      onTap: null,
      child: Card(
        color: filmophileBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(16),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2lsaG91ZXR0ZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                ),
                title: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.righteous().fontFamily,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  'Rank #' + index,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                    fontSize: 16,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon((true) ? addFriend[0] : addFriend[1]),
                      color: (true) ? addFriendColor[0] : addFriendColor[1],
                      onPressed: () => {null},
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () => {null},
                    )
                  ],
                ),
                onTap: () {},
                selected: true,
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  color: Colors.white),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        listRank[int.parse(rank) - 1] + " ",
                        style: TextStyle(
                          color: filmophileBlue,
                          fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                          fontSize: 16,
                        ),
                      ),
                      for (int i = 0; i < int.parse(rank); i++)
                        Icon(Icons.whatshot_outlined, color: filmophileOrange)
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Record :",
                    style: TextStyle(
                      color: filmophileBlue,
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                movie,
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.righteous().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " Movies watched",
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.rhodiumLibre().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                episode,
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.righteous().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " Episodes watched",
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.rhodiumLibre().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                following,
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.righteous().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " Following",
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.rhodiumLibre().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                followers,
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.righteous().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " Followers",
                                style: TextStyle(
                                  color: filmophileBlue,
                                  fontFamily:
                                      GoogleFonts.rhodiumLibre().fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
