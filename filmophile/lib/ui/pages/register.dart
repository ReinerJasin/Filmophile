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
      // appBar: AppBar(
      //   title: Text("Register"),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
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
                          Row(),
                          // Form
                          TextFormField(
                            controller: ctrlName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Username",
                              suffixIcon: Icon(Icons.perm_identity_outlined),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
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
                              suffixIcon: Icon(Icons.email_outlined),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
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
                              suffixIcon: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
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
                              labelText: "Password",
                              suffixIcon: Icon(Icons.lock_outline),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileBlue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: filmophileOrange),
                              ),
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
                          ElevatedButton.icon(
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
                            icon: Icon(Icons.save),
                            label: Text("Register"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange[400],
                              elevation: 0,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Login.routeName);
                            },
                            child: Text(
                              "Already registered? Login.",
                              style: TextStyle(
                                  color: Colors.deepOrange[400], fontSize: 16),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
