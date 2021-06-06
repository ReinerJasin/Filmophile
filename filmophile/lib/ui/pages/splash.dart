part of 'pages.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  _loadSplash() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, checkAuth);
  }

  void checkAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Navigator.pushReplacementNamed(context, MainMenu.routeName);
      ActivityServices.showToast(
          "Welcome back " + auth.currentUser.email, Colors.blue);
    } else {
      Navigator.pushReplacementNamed(context, Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: filmophileSoftBlue,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5000),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: filmophileBlue.withOpacity(.5),
                        blurRadius: 30.0,
                        spreadRadius: 5.0,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Lose yourself in every story!",
                  style: TextStyle(
                    color: filmophileBlue,
                    fontSize: 24,
                    fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.15),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/filmophile-text.png",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            height: MediaQuery.of(context).size.height,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "by Reiner Jasin",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: filmophileBlue,
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                    ),
                  ),
                  Text(
                    "version 1.0.0",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: filmophileBlue,
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
