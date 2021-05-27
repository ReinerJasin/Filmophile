part of 'widgets.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  final Function press;
  final String type;

  const MediaCard({Key key, this.media, this.press, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference productCollection = FirebaseFirestore.instance
        .collection("watchlists")
        .doc(uid)
        .collection(type+ media.id);

    productCollection.get().then((value) {
      value.docs.forEach((element) {
        if (media.id == element["mediaId"]) {
          media.timestamp = element["timestamp"];
        }

    (context as Element).markNeedsBuild();
      });
    });

    // (context as Element).markNeedsBuild();

    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(color: filmophileSoftBlue),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      Constant.IMAGE_BASE_URL + media.poster,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    media.judul,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    (media.timestamp != null)
                        ? media.timestamp
                        : "No timestamp",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xffB9D660),
                      fontFamily: GoogleFonts.righteous().fontFamily,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
