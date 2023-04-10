import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String title;
  final String description;
  final List<String> tags;
  final Timestamp date;
  final String userId;

  Blog(this.title, this.description, this.tags, this.date, this.userId);

  factory Blog.fromSnapshot(DocumentSnapshot snapshot) {
    return Blog(
        snapshot['title'],
        snapshot['description'],
        (snapshot['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
        snapshot['date'],
        snapshot['userId']);
  }
}
