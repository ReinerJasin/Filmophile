part of 'pages.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Users> listUser = [];
  List<String> ranks = ["Bronze", "Silver", "Gold", "Platinum", "Filmophile"];
  List<String> categories = ["Global", "Following"];

  Users currentUser;
  int refresh = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserService.getUsers();
    setState(() {
      UserService.getUsers().then((value) => {
            listUser = value,
          });
    });

    UserService.getCurrentUser().then((value) {
      // print(value.name + " MANTAP");
      currentUser = new Users("", value.profilePicture, value.name, "", "", "",
          "", "", "", value.following, value.followers, value.rank);
      if (currentUser != null && refresh == 0) {
        (context as Element).markNeedsBuild();
        refresh = 1;
      }
    });

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
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
            Expanded(
              child: Container(
                color: filmophileSoftBlue,
                child: FutureBuilder(
                  future: UserService.getUsers(),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.558441,
                          ),
                          itemBuilder: (context, index) => AccountCard(
                            name: listUser[index].name,
                            rank: listUser[index].rank,
                            movie: listUser[index].movie,
                            episode: listUser[index].episode,
                            following: listUser[index].following,
                            followers: listUser[index].followers,
                            index: index.toString(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
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
