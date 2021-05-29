import 'package:flutter/material.dart';

Widget nesLogo({required double width, required double height}) => Container(
      width: width * 0.65,
      height: height * 0.40,
      child: Image.asset(
        'asset/nes_logo.png',
        fit: BoxFit.fill,
      ),
    );
