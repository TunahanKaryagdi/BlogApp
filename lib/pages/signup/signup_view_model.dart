import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/active_user.dart';
import '../../models/user.dart' as UserModel;
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/custom_navigator.dart';
import '../../utils/firebase_collection_enum.dart';
import '../../utils/string_constants.dart';
import '../main/main_view.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.typeSth;
    }
    return null;
  }

  Future<bool> signUp(BuildContext context) async {
    changeLoading();
    User? user = await _authService.signup(email.text, password.text);
    if (user == null) {
      //error message
      changeLoading();
      return false;
    } else {
      UserModel.User newUser =
          UserModel.User(name.text, surname.text, email.text);
      await _firestoreService.saveToFirebase(
          newUser, FirebaseCollections.users);

      if (context.mounted) {
        setActiveUser(context, newUser);
        changeLoading();
      }
      return true;
    }
  }

  void setActiveUser(BuildContext context, UserModel.User user) {
    context
        .read<ActiveUser>()
        .setActiveUser('adfa', user.name, user.surname, user.email);
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
