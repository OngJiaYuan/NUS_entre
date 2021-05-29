import 'package:flutter/material.dart';

Widget nesAppBar(context) => AppBar(
      leading: Icon(Icons.menu),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print("Search Pressed");
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            print("More Pressed");
          },
        ),
      ],
    );
