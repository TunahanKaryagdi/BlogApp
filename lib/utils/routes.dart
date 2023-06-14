import 'package:blog_app/pages/add/add_view.dart';
import 'package:blog_app/pages/detail/detail_view.dart';
import 'package:blog_app/pages/home/home_view.dart';
import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/pages/main/main_view.dart';
import 'package:blog_app/pages/profile/profile_view.dart';
import 'package:blog_app/pages/signup/signup_view.dart';
import 'package:blog_app/pages/splash/splash_view.dart';
import 'package:blog_app/utils/strings.dart';
import 'package:flutter/material.dart';

import '../models/blog.dart';

final Map<String, WidgetBuilder> customRoutes = {
  Strings.mainRoute: (context) => const MainView(),
  Strings.splashRoute: (context) => const SplashView(),
  Strings.loginRoute: (context) => const LoginView(),
  Strings.signupRoute: (context) => const SignupView(),
  Strings.homeRoute: (context) => const HomeView(),
  Strings.detailRoute: (context) {
    final Blog blog = ModalRoute.of(context)?.settings.arguments as Blog;
    return DetailView(blog: blog);
  },
  Strings.addRoute: (context) => const AddView(),
  Strings.profileRoute: (context) => const ProfileView()
};
