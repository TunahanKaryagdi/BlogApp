import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Blog {
  final String title;
  final String description;
  final List<String> tags;
  final Timestamp date;
  final User? user;

  Blog(this.title, this.description, this.tags, this.date, {this.user});

  factory Blog.fromSnapshot(DocumentSnapshot snapshot, {User? user}) {
    return Blog(
        snapshot['title'],
        snapshot['description'],
        (snapshot['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
        snapshot['date'],
        user: user);
  }
}
