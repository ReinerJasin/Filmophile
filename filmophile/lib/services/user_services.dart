part of 'services.dart';

class UserService {
  // static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  static void getUsers() async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    // String msg = "";
    // String token = "";
    String uid = FirebaseAuth.instance.currentUser.uid;

    // await userCollection.where('uid', isEqualTo: uid).get().then((value) => {
    await userCollection.get().then((value) => {
          value.docs.forEach((element) {
            //kayak gini
            print(element["name"]);
          })
        });

    // return "msg";
  }

  static Future<Users> getCurrentUser() async {
    await Firebase.initializeApp();
    // String msg = "";
    // String token = "";
    Users user;
    String uid = FirebaseAuth.instance.currentUser.uid;
            // print(uid + "nih");

    await userCollection.where('uid', isEqualTo: uid).get().then((value) => {
          value.docs.forEach((element) {
            //kayak gini
            user = new Users("", element["profilePicture"], element["name"], "",
                "", "", "", "", "", element["following"], element["followers"], element["rank"]);
            // print(element["name"]);
          })
        });

    return user;
  }
}
