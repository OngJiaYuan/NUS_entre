import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/screens/add_news.dart';
import 'package:nus_entreprenuership_app/screens/chat.dart';
import 'package:nus_entreprenuership_app/screens/homeScreen.dart';
import 'package:nus_entreprenuership_app/screens/MentorListScreen.dart';

import 'package:nus_entreprenuership_app/screens/login_screen.dart';
import 'package:nus_entreprenuership_app/screens/login_textfield_screen.dart';
import 'package:nus_entreprenuership_app/screens/news_page.dart';
import 'package:nus_entreprenuership_app/screens/profile.dart';
import 'package:nus_entreprenuership_app/screens/profile_image_upload.dart';
import 'package:nus_entreprenuership_app/screens/registrationScreen.dart';
import 'package:nus_entreprenuership_app/screens/update_profile.dart';
import 'package:nus_entreprenuership_app/screens/youtube_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        MemberList.id: (context) => MemberList(),
        LoginTextfieldScreen.id: (context) => LoginTextfieldScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ImageUpload.id: (context) => ImageUpload(),
        YoutubeScreen.id: (context) => YoutubeScreen(),
        profilePage.id: (context) => profilePage(),
        newsfeed.id: (context) => newsfeed(),
        addnews.id: (context) => addnews(),
        ChatScreen.id: (context) => ChatScreen(),
        ProfileUpdate.id: (context) => ProfileUpdate(),
      },
    );
  }
}
