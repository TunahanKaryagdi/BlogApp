import 'package:blog_app/pages/detail/detail_view.dart';
import 'package:blog_app/pages/splash/splash_view.dart';
import 'package:blog_app/services/local/user_manager.dart';
import 'package:blog_app/utils/routes.dart';
import 'package:blog_app/utils/string_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/blog.dart';

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
        routes: customRoutes,
        onGenerateRoute: (settings) {
          if (settings.name == StringConstants.detailRoute) {
            final args = settings.arguments as Blog;
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => DetailView(blog: args),
            );
          }
          return null;
        },
        initialRoute: StringConstants.splashRoute,
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
