import 'package:assignment_bluestacks/home_screen/home.dart';
import 'package:assignment_bluestacks/login_screen/login.dart';
import 'package:flutter/material.dart';

class GameApplication extends StatefulWidget {
  GameApplication({Key key}) : super(key: key);

  @override
  _GameApplicationState createState() => _GameApplicationState();
}

class _GameApplicationState extends State<GameApplication> {
  @override
  Widget build(BuildContext context) {
    bool _loggedIn = true;

    if (_loggedIn)
      return LoginView();
    else
      return HomeView();
  }
}
