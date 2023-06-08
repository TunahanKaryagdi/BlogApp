import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/pages/main/main_view.dart';
import 'package:blog_app/pages/splash/splash_view_model.dart';
import 'package:blog_app/utils/custom_navigator.dart';
import 'package:blog_app/widgets/custom_title.dart';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      _viewModel = SplashViewModel();
      await _viewModel.controlIsLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: customPageTitle(context, 'Splash'),
    ));
  }
}
