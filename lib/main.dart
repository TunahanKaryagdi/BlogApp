import 'package:flutter/material.dart';

import 'pages/login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown).copyWith(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)),
      home: const LoginView(),
    );
  }
}
