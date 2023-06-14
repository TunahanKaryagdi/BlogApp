import 'package:flutter/material.dart';

import '../../utils/strings.dart';
import '../add/add_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _children = [
    const HomeView(),
    const AddView(),
    const ProfileView()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Strings.home,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: Strings.add),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc), label: Strings.profile),
        ],
      ),
    );
  }
}
