part of 'pages.dart';

class NontonTv extends StatefulWidget {
  final String tvId;
  final String tvJudul;
  final String status;
  final String maxSeason;
  final String maxEpisode;
  final String timestamp;
  final String notes;

  const NontonTv(
      {Key key,
      this.tvId,
      this.tvJudul,
      this.status,
      this.maxSeason,
      this.maxEpisode,
      this.timestamp,
      this.notes})
      : super(key: key);
  @override
  _NontonTvState createState() => _NontonTvState();
}

class _NontonTvState extends State<NontonTv> {
  final _formKey = GlobalKey<FormState>();
  final ctrlStatus = TextEditingController();
  final ctrlSeason = TextEditingController();
  final ctrlEpisode = TextEditingController();
  final ctrlTimestamp = TextEditingController();
  final ctrlNotes = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  String type = "tvshow";

  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tvJudul),
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
                            controller: ctrlSeason,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Season (max : " + widget.maxSeason + ")",
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
                              } else if (int.parse(value) >
                                  int.parse(widget.maxSeason)) {
                                return "Season " + value + " doesn't exist!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: ctrlEpisode,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Episode (max : " + widget.maxEpisode + ")",
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
                              } else if (int.parse(value) >
                                  int.parse(widget.maxEpisode)) {
                                return "Episode " + value + " doesn't exist!";
                              }  else {
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
                                        widget.tvId,
                                        type,
                                        ctrlStatus.text,
                                        ctrlSeason.text,
                                        ctrlEpisode.text,
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
