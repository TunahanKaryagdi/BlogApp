import 'package:blog_app/models/active_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;

  final String surname;

  final String email;

  final int follow;

  final int follower;

  final String photo;

  User(this.name, this.surname, this.email, this.follow, this.follower,
      this.photo);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(snapshot['name'], snapshot['surname'], snapshot['email'],
        snapshot["follow"], snapshot["follower"], snapshot['photo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'follow': follow,
      'follower': follower,
      'photo': photo
    };
  }

  factory User.fromActiveUser(ActiveUser activeUser) {
    return User(activeUser.name, activeUser.surname, activeUser.email,
        activeUser.follow, activeUser.follower, activeUser.photo);
  }
}
