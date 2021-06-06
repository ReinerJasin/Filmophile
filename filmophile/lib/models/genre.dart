part of 'models.dart';

class Genre {
  String id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.createGenre(Map<String, dynamic> object) {
    return Genre(
      id: object['id'].toString(),
      name: object['name'],
    );
  }
}
