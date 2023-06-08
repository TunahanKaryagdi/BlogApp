import 'package:blog_app/utils/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/active_user.dart';

class UserManager {
  static late Box<ActiveUser> _userBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ActiveUserAdapter());
    _userBox = await Hive.openBox(StringConstants.userBoxName);
  }

  static ActiveUser? getUserData() {
    return _userBox.get(StringConstants.userKey);
  }

  static Future<void> setUserData(ActiveUser data) async {
    await _userBox.put(StringConstants.userKey, data);
  }

  static Future<void> deleteUserData() async {
    await _userBox.delete(StringConstants.userKey);
  }
}
