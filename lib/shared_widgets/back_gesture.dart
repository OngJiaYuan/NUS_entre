import 'package:flutter/material.dart';

Widget backGesture({required onTap}) => GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Icon(Icons.arrow_back, color: Colors.black),
    );
