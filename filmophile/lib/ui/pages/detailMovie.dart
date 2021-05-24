part of 'pages.dart';

class DetailMovie extends StatefulWidget {
  final String movieId;

  const DetailMovie({Key key, this.movieId}) : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  Movie movie;
  String judulCard = "";
  List<String> genreList;
  String genreCard = "";

  @override
  Widget build(BuildContext context) {
    ApiServices.getMovieDetail(widget.movieId).then((value) => {
          setState(() {
            movie = new Movie(
              id: value.id,
              judul: value.judul,
              overview: value.overview,
              backdrop: value.backdrop,
              tanggal: value.tanggal,
              genreIds: value.genreIds,
            );
            judulCard = movie.judul + " (";
            judulCard += movie.tanggal.substring(0, 4);
            judulCard += ")";
          })
        });
    ApiServices.getGenres(movie.genreIds).then((value) => {
          setState(() {
            // genreList = value;
            // for (int i = 0; i < genreList.length; i++) {
              genreCard = value;
            print("DEBUG 2");
            print(genreList);
            // }
          })
        });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TV Show Detail",
          style: TextStyle(
              color: filmophileBlue,
              fontFamily: GoogleFonts.righteous().fontFamily),
        ),
        iconTheme: IconThemeData(color: filmophileBlue),
      ),
      body: Column(
        children: [
          (movie != null)
              ? Stack(
                  children: [
                    // Kalau ada datanya
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 11 / 18,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              Constant.IMAGE_BASE_URL + movie.backdrop,
                            ),
                            fit: BoxFit.cover),
                        color: filmophileSoftBlue,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 11 / 18,
                      decoration: BoxDecoration(
                        color: filmophileSoftBlue,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.width * 11 / 18) -
                          80 +
                          20,
                      margin: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.width * 11 / 18) -
                              20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: ListView(
                          children: [
                            Text(
                              judulCard,
                              style: TextStyle(
                                fontFamily: GoogleFonts.righteous().fontFamily,
                                fontSize: 28,
                                color: filmophileBlue,
                              ),
                            ),
                            Text(
                              genreCard,
                              style: TextStyle(
                                fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
                                fontSize: 18,
                                color: filmophileBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Text("nd ada data")
        ],
      ),
    );
  }
}
