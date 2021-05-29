import 'package:flutter/material.dart';

Widget backGesture({required  onTap}) => GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Text(
        'back',
        style: TextStyle(color: Colors.blue),
      ),
    );
