part of 'models.dart';

class Users extends Equatable{
  final String uid;
  final String profilePicture;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;

  Users(
    this.uid,
    this.profilePicture,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
    uid,
    profilePicture,
    name,
    phone,
    email,
    password,
    createdAt,
    updatedAt
  ];

}