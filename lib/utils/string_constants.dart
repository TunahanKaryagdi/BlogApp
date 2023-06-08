import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String appName = "Blog App";

//Routes
  static const String splashRoute = "/splash";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String mainRoute = "/main";
  static const String homeRoute = "/home";
  static const String detailRoute = "/detail";
  static const String addRoute = "/add";
  static const String profileRoute = "/profile";

  static const String helloText = 'Hello';
  static const String email = 'Email';
  static const String login = 'Login';
  static const String home = 'Home';

  static const String signup = 'Sign up';
  static const String password = 'Password';
  static const String create = 'Create a Blog';
  static const String title = 'Title';
  static const String description = 'Description';
  static const String tags = 'Tags';
  static const String save = 'Save';
  static const String profile = 'Profile';
  static const String name = "Name";
  static const String surname = "Surname";
  static const String unknown = "Unknown";
  static const String typeSth = "Type Something";
  static const String add = "Add";

  static const String follow = "Follow";
  static const String follower = "Follower";
  static const String photo = "Photo";

  static const String defaultImage =
      'https://avatars.githubusercontent.com/u/92988984?s=400&v=4';

  static const String userBoxName = "activeUser";
  static const String userKey = 'userKey';
}
