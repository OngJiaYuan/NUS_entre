import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/screens/homeScreen.dart';
import 'package:nus_entreprenuership_app/screens/MentorListScreen.dart';

import 'package:nus_entreprenuership_app/screens/login_screen.dart';
import 'package:nus_entreprenuership_app/screens/login_textfield_screen.dart';
import 'package:nus_entreprenuership_app/screens/registrationScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(
              title: 'Home page',
            ),
        LoginScreen.id: (context) => LoginScreen(),
        MentorListScreen.id: (context) => MentorListScreen(
              title: 'Mentor screen page',
            ),
        LoginTextfieldScreen.id: (context) => LoginTextfieldScreen(),
        registrationScreen.id: (context) => registrationScreen(),
      },
    );
  }
}
