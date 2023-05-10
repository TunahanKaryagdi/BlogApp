import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../models/active_user.dart';
import '../../models/user.dart' as UserModel;
import '../../services/auth_service.dart';
import '../../utils/string_constants.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  String? textFieldValidator(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.typeSth;
    }
    return null;
  }

  Future<bool> login(BuildContext context) async {
    changeLoading();
    User? user = await _authService.login(email.text, password.text);
    if (user != null) {
      UserModel.User activeUser = await getUserOnLogin(user.email!);
      if (context.mounted) {
        logActiveUser(context, activeUser);
        changeLoading();
      }
      return true;
    } else {
      changeLoading();
      return false;
    }
  }

  //login olunduysa
  // user emaile göre getir
  //active user ı güncelle
  //başka sayafaya git

  Future<UserModel.User> getUserOnLogin(String email) async {
    final snapshots = await _firestoreService
        .getDocumentFromFirebase(FirebaseCollections.users);
    final snapshot = snapshots.docs.firstWhere((doc) => doc['email'] == email);
    UserModel.User user = UserModel.User.fromSnapshot(snapshot);
    return user;
  }

  void logActiveUser(BuildContext context, UserModel.User user) {
    context
        .read<ActiveUser>()
        .setActiveUser('adfa', user.name, user.surname, user.email);
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
