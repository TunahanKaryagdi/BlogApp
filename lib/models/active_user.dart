import 'package:flutter/foundation.dart';

class ActiveUser extends ChangeNotifier {
  String? name;
  String? surname;
  String? email;

  void logUser(String newName, String newSurname, String newEmail) {
    name = newName;
    surname = newSurname;
    email = newEmail;
    notifyListeners();
  }
}
