part of 'models.dart';

class Users extends Equatable {
  final String uid;
  final String profilePicture;
  final String name;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;

  final String movie;
  final String episode;
  final String following;
  final String followers;
  final String rank;

  Users(
    this.uid,
    this.profilePicture,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.movie,
    this.episode,
    this.following,
    this.followers,
    this.rank,
  );

  @override
  List<Object> get props =>
      [uid, profilePicture, name, email, password, createdAt, updatedAt];
}
