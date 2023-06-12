import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Blog {
  final String? id;
  final String title;
  final String description;
  final List<String> tags;
  List<String> like;
  final Timestamp date;
  final String photo;
  final User user;

  Blog(this.id, this.title, this.description, this.tags, this.like, this.date,
      this.photo, this.user);

  factory Blog.fromSnapshot(DocumentSnapshot snapshot, User user) {
    return Blog(
        snapshot.id,
        snapshot['title'],
        snapshot['description'],
        (snapshot['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
        (snapshot['like'] as List<dynamic>).map((e) => e.toString()).toList(),
        snapshot['date'],
        snapshot['photo'],
        user);
  }

  Map<String, dynamic> toMap(String id) {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'like': like,
      'date': date,
      'photo': photo,
      'userId': id
    };
  }
}
