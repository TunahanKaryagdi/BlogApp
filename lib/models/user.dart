import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firestore_service.dart';

class User implements Model {
  final String name;
  final String surname;
  final String email;

  User(this.name, this.surname, this.email);

  @override
  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      snapshot['name'],
      snapshot['surname'],
      snapshot['email'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'name': name, 'surname': surname, 'email': email};
  }
}
