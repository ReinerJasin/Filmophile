part of 'pages.dart';

class DetailMovie extends StatefulWidget {
  final String movieId;

  const DetailMovie({Key key, this.movieId}) : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  Movie movie;

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
          })
        });
    return Scaffold(
      appBar: AppBar(
        title: Text("COBA"),
      ),
      body: Column(
        children: [
          (movie != null) ? Text(movie.overview) : Text("nd ada data")
          // Text(movie.judul),
          // Text(movie.overview),
          // Text(movie.backdrop),
          // Text(movie.tanggal),
          // Text(movie.genreIds.toString()),
        ],
      ),
    );
  }
}

// class DetailMovie extends StatelessWidget {
//   final String movieId;
//   const DetailMovie({Key key, this.movieId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
        
//         // title: Text(movie.judul),
//       ),
//     );
//   }
// }
