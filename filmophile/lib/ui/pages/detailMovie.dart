part of 'pages.dart';

class DetailMovie extends StatelessWidget {
  final Movie movie;
  const DetailMovie({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.judul),
      ),
    );
  }
}
