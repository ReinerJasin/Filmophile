part of 'services.dart';

class UserService {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  static Future<List<Users>> getUsers() async {
    await Firebase.initializeApp();

    List<Users> listUser = [];

    await userCollection
        .orderBy("followers", descending: true)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
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
    Users user;
    String uid = FirebaseAuth.instance.currentUser.uid;

    await userCollection.where('uid', isEqualTo: uid).get().then((value) => {
          value.docs.forEach((element) {
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
          })
        });

    return user;
  }
}
