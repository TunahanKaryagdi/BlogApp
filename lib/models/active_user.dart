import 'package:flutter/foundation.dart';

class ActiveUser extends ChangeNotifier {
  String? id;
  String? name;
  String? surname;
  String? email;

  void logUser(
      String? newId, String? newName, String? newSurname, String? newEmail) {
    id = newId;
    name = newName;
    surname = newSurname;
    email = newEmail;
    notifyListeners();
  }
}
