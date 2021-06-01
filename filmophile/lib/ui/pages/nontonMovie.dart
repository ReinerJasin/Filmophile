part of 'pages.dart';

class NontonMovie extends StatefulWidget {
  final String movieId;
  final String movieJudul;
  final String status;
  final String timestamp;
  final String notes;

  const NontonMovie(
      {Key key,
      this.movieId,
      this.movieJudul,
      this.status,
      this.timestamp,
      this.notes})
      : super(key: key);
  @override
  _NontonMovieState createState() => _NontonMovieState();
}

class _NontonMovieState extends State<NontonMovie> {
  final _formKey = GlobalKey<FormState>();
  final ctrlStatus = TextEditingController();
  final ctrlTimestamp = TextEditingController();
  final ctrlNotes = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  String type = "movie";

  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieJudul),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: ctrlStatus,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Status",
                              labelStyle: TextStyle(color: filmophileBlue),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
                            ),
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.righteous().fontFamily,
                              fontSize: 18,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill the field!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: ctrlTimestamp,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Timestamp",
                              labelStyle: TextStyle(color: filmophileBlue),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
                            ),
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.righteous().fontFamily,
                              fontSize: 18,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill the field!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: ctrlNotes,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Notes",
                              labelStyle: TextStyle(color: filmophileBlue),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
                            ),
                            style: TextStyle(
                              color: filmophileBlue,
                              fontFamily: GoogleFonts.righteous().fontFamily,
                              fontSize: 18,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill the field!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await MediaServices.addWatchlist(
                                        auth.currentUser.uid,
                                        widget.movieId,
                                        type,
                                        ctrlStatus.text,
                                        null,
                                        null,
                                        ctrlTimestamp.text,
                                        ctrlNotes.text)
                                    .then((value) {
                                  if (value == true) {
                                    ActivityServices.showToast(
                                        "Changes saved!", Colors.green);
                                    // clearForm();
                                    setState(() {
                                      isLoading = false;
                                    });
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailMovie(movieId: widget.movieId,)));
                            Navigator.pop(context);
                                  } else { 
                                    ActivityServices.showToast(
                                        "Something's wrong, please try again!",
                                        Colors.red);
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              alignment: Alignment.center,
                              child: Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily:
                                      GoogleFonts.righteous().fontFamily,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: filmophileOrange,
                              elevation: 0,
                              padding: EdgeInsets.all(8),
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
