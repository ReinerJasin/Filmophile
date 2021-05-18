part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  // final ctrlPhone = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final ctrlPasswordConfirm = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              children: [
                // Foto Logo
                Image.asset(
                  "assets/images/filmophile-text.png",
                  height: 150,
                ),

                // Banner Title
                Container(
                  height: 2,
                  color: filmophileOrange,
                ),
                Container(
                  height: 80,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  color: filmophileBlue,
                  alignment: Alignment.center,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontFamily: GoogleFonts.righteous().fontFamily,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  color: filmophileOrange,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: ctrlName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(color: filmophileBlue),
                              suffixIcon: Icon(
                                Icons.perm_identity_outlined,
                                color: filmophileBlue,
                              ),
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
                            controller: ctrlEmail,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: filmophileBlue),
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: filmophileBlue,
                              ),
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
                                if (!EmailValidator.validate(value)) {
                                  return "Email isn't valid";
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
                          TextFormField(
                            controller: ctrlPassword,
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: filmophileBlue),
                              suffixIcon: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: filmophileBlue,
                                ),
                              ),
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
                              // nanti validator nya di tambah
                              return value.length < 6
                                  ? "Password must have at least 6 characters!"
                                  : null;
                            },
                          ),
                          TextFormField(
                            controller: ctrlPasswordConfirm,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password Confirmation",
                              labelStyle: TextStyle(color: filmophileBlue),
                              suffixIcon: Icon(
                                Icons.lock_outline,
                                color: filmophileBlue,
                              ),
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
                              return value != ctrlPassword.text
                                  ? "Password do not match!"
                                  : null;
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
                                Users users = new Users(
                                    "",
                                    "",
                                    ctrlName.text,
                                    ctrlPasswordConfirm.text,
                                    ctrlEmail.text,
                                    ctrlPassword.text,
                                    "",
                                    "");
                                await AuthServices.signUp(users).then((value) {
                                  if (value == "success") {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        "Register success", Colors.green);
                                    Navigator.pushReplacementNamed(
                                        context, Login.routeName);
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        value, Colors.red);
                                  }
                                });

                                //melanjutkan ke tahap berikutnya
                                // Navigator.pushReplacementNamed(
                                //     context, MainMenu.routeName);
                              } else {
                                //kosongkan aja
                                Fluttertoast.showToast(
                                    msg: "Please check the fields!",
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              alignment: Alignment.center,
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily:
                                      GoogleFonts.righteous().fontFamily,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: filmophileBlue,
                              elevation: 0,
                              padding: EdgeInsets.all(8),
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Login.routeName);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              alignment: Alignment.center,
                              child: Text(
                                "Log In",
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
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushReplacementNamed(
                          //         context, Login.routeName);
                          //   },
                          //   child: Text(
                          //     "Already registered? Login.",
                          //     style: TextStyle(
                          //         color: Colors.deepOrange[400], fontSize: 16),
                          //   ),
                          // )
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
