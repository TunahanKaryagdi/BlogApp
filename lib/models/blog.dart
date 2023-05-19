import 'package:blog_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Blog implements Model {
  final String title;
  final String description;
  final List<String> tags;
  final Timestamp date;
  final String photo;
  final User? user;

  Blog(this.title, this.description, this.tags, this.date, this.photo,
      {this.user});

  @override
  factory Blog.fromSnapshot(DocumentSnapshot snapshot, {User? user}) {
    return Blog(
        snapshot['title'],
        snapshot['description'],
        (snapshot['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
        snapshot['date'],
        snapshot['photo'],
        user: user);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'date': date,
      'photo': 'https://avatars.githubusercontent.com/u/92988984?s=400&v=4',
      'userId': 'F3yg2wN2gPEvVwxIoOUL'
    };
  }
}
