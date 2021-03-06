part of 'models.dart';

class Movie {
  String id;
  String judul;
  String overview;
  String backdrop;
  String tanggal;
  List<dynamic> genreIds;

  // Yang diambil dari firebase
  String status; // Finished || Watching || Not Finished
  String timestamp; // 1:23:53  (hour):(minute):(second)
  String isFavorite; // True || False
  String notes; //notes

  Movie({
    this.id,
    this.judul,
    this.overview,
    this.backdrop,
    this.tanggal,
    this.genreIds,
    this.status,
    this.timestamp,
    this.isFavorite,
    this.notes,
  });

  factory Movie.createMovie(Map<String, dynamic> object) {
    return Movie(
      id: object['id'].toString(),
      judul: object['title'],
      overview: object['overview'],
      backdrop: object['backdrop_path'],
      tanggal: object['release_date'],
      genreIds: object['genres'],
    );
  }
}
