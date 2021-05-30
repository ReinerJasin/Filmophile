part of 'pages.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  List<Users> listUser = [];
  @override
  Widget build(BuildContext context) {

    UserService.getUsers();
    setState(() {
      UserService.getUsers().then((value) => {
          listUser = value,
      });
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        // press: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             (category[selectedIndex] == "movie")
                        //                 ? DetailMovie(
                        //                     movieId: listMedia[index].id)
                        //                 : DetailTv(tvId: listMedia[index].id))),
                      ),
                    ),
                  );
                }
              },
            ),
        
      ),
    );
  }
}