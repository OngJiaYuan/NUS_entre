import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/screens/MentorListScreen.dart';
import 'package:nus_entreprenuership_app/screens/homeScreen.dart';
import 'package:nus_entreprenuership_app/screens/login_screen.dart';
import 'package:nus_entreprenuership_app/screens/news_page.dart';
import 'package:nus_entreprenuership_app/screens/profile.dart';
import 'package:nus_entreprenuership_app/screens/youtube_channel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nus_entreprenuership_app/shared_widgets/nes_logo.dart';

Widget nesSideBar(context) => Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: nesLogo(),
          )),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, MyHomePage.id);
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, profilePage.id);
            },
          ),
          ListTile(
            title: Text('News Feed'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, newsfeed.id);
            },
          ),
          ListTile(
            title: Text('Member List'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, MemberList.id);
            },
          ),
          ListTile(
            title: Text('Educational Videos'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, YoutubeScreen.id);
            },
          ),
          Expanded(child: Container()),
          ListTile(
            title: Text('Log out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ],
      ),
    );
