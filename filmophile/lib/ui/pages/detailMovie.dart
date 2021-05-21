part of 'pages.dart';

class DetailMovie extends StatelessWidget {
  final String movieId;
  const DetailMovie({Key key, this.movieId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(movie.judul),
      ),
    );
  }
}
