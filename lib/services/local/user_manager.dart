import 'package:blog_app/utils/strings.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/active_user.dart';

class UserManager {
  static late Box<ActiveUser> _userBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ActiveUserAdapter());
    _userBox = await Hive.openBox(Strings.userBoxName);
  }

  static ActiveUser? getUserData() {
    return _userBox.get(Strings.userKey);
  }

  static Future<void> setUserData(ActiveUser data) async {
    await _userBox.put(Strings.userKey, data);
  }

  static Future<void> deleteUserData() async {
    await _userBox.delete(Strings.userKey);
  }
}
