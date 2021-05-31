part of 'services.dart';

class UserService {
  // static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  static Future<List<Users>> getUsers() async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    // String msg = "";
    // String token = "";
    String uid = FirebaseAuth.instance.currentUser.uid;

    List<Users> listUser = [];

    // await userCollection.where('uid', isEqualTo: uid).get().then((value) => {
    await userCollection.orderBy("followers", descending: true).get().then((value) => {
          value.docs.forEach((element) {
            //kayak gini
            // print(element["name"]);
            Users user = new Users(
                element["uid"],
                element["profilePicture"],
                element["name"],
                element["email"],
                element["password"],
                element["createdAt"],
                element["updatedAt"],
                element["moviesWatched"],
                element["episodesWatched"],
                element["following"],
                element["followers"],
                element["rank"]);
            listUser.add(user);
          })
        });

    return listUser;
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
            user = new Users(
                "",
                element["profilePicture"],
                element["name"],
                "",
                "",
                "",
                "",
                "",
                "",
                element["following"],
                element["followers"],
                element["rank"]);
            // print(element["name"]);
          })
        });

    return user;
  }
}
