import 'package:blog_app/pages/add/add_view.dart';
import 'package:blog_app/pages/detail/detail_view.dart';
import 'package:blog_app/pages/home/home_view.dart';
import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/pages/main/main_view.dart';
import 'package:blog_app/pages/profile/profile_view.dart';
import 'package:blog_app/pages/signup/signup_view.dart';
import 'package:blog_app/pages/splash/splash_view.dart';
import 'package:blog_app/utils/string_constants.dart';
import 'package:flutter/material.dart';

import '../models/blog.dart';

final Map<String, WidgetBuilder> customRoutes = {
  StringConstants.mainRoute: (context) => const MainView(),
  StringConstants.splashRoute: (context) => const SplashView(),
  StringConstants.loginRoute: (context) => const LoginView(),
  StringConstants.signupRoute: (context) => const SignupView(),
  StringConstants.homeRoute: (context) => const HomeView(),
  StringConstants.detailRoute: (context) {
    final Blog blog = ModalRoute.of(context)?.settings.arguments as Blog;
    return DetailView(blog: blog);
  },
  StringConstants.addRoute: (context) => const AddView(),
  StringConstants.profileRoute: (context) => const ProfileView()
};
