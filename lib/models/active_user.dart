import 'package:flutter/foundation.dart';

class ActiveUser extends ChangeNotifier {
  String? id;
  String? name;
  String? surname;
  String? email;
  int? follow;
  int? follower;
  String? photoUrl;

  void setActiveUser(String? newId, String? newName, String? newSurname,
      String? newEmail, int? newFollow, int? newFollower, String? newPhotoUrl) {
    id = newId;
    name = newName;
    surname = newSurname;
    email = newEmail;
    follow = newFollow;
    follower = newFollower;
    photoUrl = newPhotoUrl;
    notifyListeners();
  }
}
