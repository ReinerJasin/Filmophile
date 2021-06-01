part of 'services.dart';

class MediaServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("watchlists");
  static DocumentReference productDocument;

  static Future<bool> addWatchlist(
      String uid,
      String mediaId,
      String type,
      String status,
      String currentSeason,
      String currentEpisode,
      String timestamp,
      String notes) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    productDocument = await productCollection
        .doc(auth.currentUser.uid)
        .collection(type + "#" + mediaId)
        .add({
      'uid': uid,
      'mediaId': mediaId,
      'type': type,
      'status': status,
      'current_season': currentSeason,
      'current_episode': currentEpisode,
      'timestamp': timestamp,
      'notes': notes,
      'createdAt': dateNow,
      'updatedAt': dateNow,
      'isFavorite': null,
    });
    return true;
  }

  static Future<bool> editWatchlist(
      String uid,
      String mediaId,
      String type,
      String status,
      String currentSeason,
      String currentEpisode,
      String timestamp,
      String notes) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    await productCollection
        .doc(auth.currentUser.uid)
        .collection(type + "#" + mediaId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // print(element.id);
        productCollection
            .doc(auth.currentUser.uid)
            .collection(type + "#" + mediaId)
            .doc(element.id)
            .update({
          'notes': notes,
          'status': status,
          'timestamp': timestamp,
          'current_season': currentSeason,
          'current_episode': currentEpisode,
        });
        // element.data().update('status', (value) => status);
        // element.data().update('timestamp', (value) => timestamp);
        // element.data().update('notes', (value) => notes);
        //udah bisa update element tinggal update di firebase
      });
    });
    print(status);
    print(timestamp);
    print(notes);
    //   .doc().update({
    // 'uid': uid,
    // 'mediaId': mediaId,
    // 'type': type,
    // 'status': status,
    // 'current_season': currentSeason,
    // 'current_episode': currentEpisode,
    // 'timestamp': timestamp,
    // 'notes': notes,
    // 'createdAt': dateNow,
    // 'updatedAt': dateNow,
    // 'isFavorite': null,
    //   });

    //     .add({
    //   'uid': uid,
    //   'mediaId': mediaId,
    //   'type': type,
    //   'status': status,
    //   'current_season': currentSeason,
    //   'current_episode': currentEpisode,
    //   'timestamp': timestamp,
    //   'notes': notes,
    //   'createdAt': dateNow,
    //   'updatedAt': dateNow,
    //   'isFavorite': null,
    // });
    return true;
  }

  static Future<bool> changeFavorite(
    String uid,
    String mediaId,
    String type,
    String isFavorite,
  ) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();

    CollectionReference productCollection = FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection(type + mediaId);

    productCollection.get().then((value) {
      value.docs.forEach((element) {
        // element.data().updateAll((key, value) => {"isFavorite": isFavorite, "updatedAt": dateNow});
      });

      if (value.docs.length == 0) {
        print(value.docs.length);
        print("media tidak ditemukan dalam firebase");
      }
    });

    // productDocument = await productCollection
    //     .doc(auth.currentUser.uid)
    //     .collection(type + "#" + mediaId)
    //     .add({
    //   'updatedAt': dateNow,
    //   'isFavorite': null,
    // })

    return true;
  }
  // static Future<bool> deleteProduct(String id) async {
  //   bool hsl = true;
  //   await Firebase.initializeApp();
  //   await productCollection.doc(id).delete().then((value) {
  //     hsl = true;
  //   }).catchError((onError) {
  //     hsl = false;
  //   });

  //   return hsl;
  // }
}
