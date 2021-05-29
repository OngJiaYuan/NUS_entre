import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/screens/MentorListScreen.dart';
import 'package:nus_entreprenuership_app/screens/login_screen.dart';

Widget nesSideBar(context) => Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('User Details'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('News Feed'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Mentor List'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, MentorListScreen.id);
            },
          ),
          ListTile(
            title: Text('Log out'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ],
      ),
    );
