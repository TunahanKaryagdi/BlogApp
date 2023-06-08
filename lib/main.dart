import 'package:blog_app/pages/login/login_view.dart';
import 'package:blog_app/pages/splash/splash_view.dart';
import 'package:blog_app/services/user_manager.dart';
import 'package:blog_app/utils/string_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserManager.initialize();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {},
      child: MaterialApp(
        title: StringConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.brown).copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.white)),
        home: const SplashView(),
      ),
    );
  }
}
