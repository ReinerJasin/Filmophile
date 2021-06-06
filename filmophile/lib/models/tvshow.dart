part of 'models.dart';

class TvShow {
  String id;
  String judul;
  String overview;
  String backdrop;
  String tanggal;
  String season;
  String episode;
  List<dynamic> genreIds;

  // Yang diambil dari firebase
  String status; // Finished || Watching || Not Finished
  String timestamp; // 1:23:53  (hour):(minute):(second)
  String isFavorite; // True || False
  String notes; //notes

  TvShow({
    this.id,
    this.judul,
    this.overview,
    this.backdrop,
    this.tanggal,
    this.season,
    this.episode,
    this.genreIds,
    this.status,
    this.timestamp,
    this.isFavorite,
    this.notes,
  });

  factory TvShow.createTvShow(Map<String, dynamic> object) {
    return TvShow(
      id: object['id'].toString(),
      judul: object['name'],
      overview: object['overview'],
      backdrop: object['backdrop_path'],
      tanggal: object['first_air_date'],
      season: object['number_of_seasons'].toString(),
      episode: object['number_of_episodes'].toString(),
      genreIds: object['genres'],
    );
  }
}
