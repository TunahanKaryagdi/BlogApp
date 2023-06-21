import 'package:blog_app/pages/splash/splash_view_model.dart';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

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
      child: Icon(
        Icons.auto_stories_outlined,
        size: context.mediaQuery.size.width * 0.5,
        color: context.appTheme.primaryColor,
      ),
    ));
  }
}
