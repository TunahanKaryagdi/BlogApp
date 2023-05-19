import 'package:blog_app/services/firestore_service.dart';
import 'package:blog_app/utils/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      QueryDocumentSnapshot userSnapshot =
          await getUserSnapshotOnLogin(user.email!);
      if (context.mounted) {
        setActiveUser(context, UserModel.User.fromSnapshot(userSnapshot),
            userSnapshot.id);
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

  Future<QueryDocumentSnapshot<Object?>> getUserSnapshotOnLogin(
      String email) async {
    final snapshots = await _firestoreService
        .getDocumentsFromFirebase(FirebaseCollections.users);
    final userSnapshot =
        snapshots.docs.firstWhere((doc) => doc['email'] == email);
    return userSnapshot;
  }

  void setActiveUser(BuildContext context, UserModel.User user, String docId) {
    context.read<ActiveUser>().setActiveUser(docId, user.name, user.surname,
        user.email, user.follow, user.follower, user.photo);
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
