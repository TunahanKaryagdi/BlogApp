import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String surname;
  final String email;

  User(this.name, this.surname, this.email);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      snapshot['name'],
      snapshot['surname'],
      snapshot['email'],
    );
  }
}
