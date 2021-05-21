part of 'models.dart';

class TvShow {
  String id;
  String judul;
  String overview;
  String backdrop;
  String poster;
  String tanggal;
  List<dynamic> genreIds;

  // Yang diambil dari firebase
  String status; // Finished || Watching || Not Finished
  String timestamp; // 1:23:53  (hour):(minute):(second)
  String isFavorite; // True || False

  TvShow({
    this.id,
    this.judul,
    this.overview,
    this.backdrop,
    this.poster,
    this.tanggal,
    this.genreIds,
    this.status,
    this.timestamp,
    this.isFavorite,
  });

  factory TvShow.createTvShow(Map<String, dynamic> object) {
    return TvShow(
      id: object['id'].toString(),
      judul: object['title'],
      overview: object['overview'],
      backdrop: object['backdrop_path'],
      poster: object['poster_path'],
      tanggal: object['release_date'],
      genreIds: object['genre_ids'],
    );
  }

}
