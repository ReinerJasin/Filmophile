part of 'models.dart';

class Media {
  String id;
  String judul;
  String poster;

  // Yang diambil dari firebase
  String status; // Finished || Watching || Not Finished
  String timestamp; // 1:23:53  (hour):(minute):(second)
  String isFavorite; // True || False
  String notes; //Description

  Media({
    this.id,
    this.judul,
    this.poster,
    this.status,
    this.timestamp,
    this.isFavorite,
    this.notes,
  });

  factory Media.createMedias(Map<String, dynamic> object, String title) {
    return Media(
      id: object['id'].toString(),
      judul: object[title],
      poster: object['poster_path'],
    );
  }
}
