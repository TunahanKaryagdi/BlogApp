import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/user.dart' as UserModel;
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/firebase_collection_enum.dart';
import '../../utils/string_constants.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.typeSth;
    }
    return null;
  }

  Future<void> signUp() async {
    User? user = await _authService.signup(email.text, password.text);
    if (user == null) {
      //error message
      return;
    }
    await _firestoreService.saveToFirebase(
        UserModel.User(name.text, surname.text, email.text),
        FirebaseCollections.users);
  }
}
