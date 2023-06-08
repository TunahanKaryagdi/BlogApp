import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../models/active_user.dart';
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
      QueryDocumentSnapshot userSnapshot =
          await getUserSnapshotOnLogin(user.email!);

      ActiveUser activeUser = ActiveUser(
          userSnapshot.id,
          userSnapshot['name'],
          userSnapshot['surname'],
          userSnapshot['email'],
          userSnapshot['follow'],
          userSnapshot['follower'],
          userSnapshot['photo']);

      await UserManager.setUserData(activeUser);
      // await Hive.openBox(StringConstants.userBoxName);
      // Hive.box(StringConstants.userBoxName).add(activeUser);

      changeLoading();

      return true;
    } else {
      changeLoading();
      return false;
    }
  }

  Future<QueryDocumentSnapshot<Object?>> getUserSnapshotOnLogin(
      String email) async {
    final snapshots = await _firestoreService
        .getDocumentsFromFirebase(FirebaseCollections.users);
    final userSnapshot =
        snapshots.docs.firstWhere((doc) => doc['email'] == email);
    return userSnapshot;
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
