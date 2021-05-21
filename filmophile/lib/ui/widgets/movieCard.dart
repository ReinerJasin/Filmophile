part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function press;

  const MovieCard({Key key, this.movie, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(color: Color(0xffC6dee7)),
        child: Stack(
          children: [
            // Image.network(
            //   Constant.IMAGE_BASE_URL + movie.poster,
            //   fit: BoxFit.fill,
            // ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      Constant.IMAGE_BASE_URL + movie.poster,
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
                    movie.judul,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    movie.tanggal,
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
