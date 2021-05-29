import 'package:flutter/material.dart';

Widget textField({
  required double width,
  required String labelText,
  String? varname,
}) =>
    Container(
      width: width * 0.75,
      height: 45,
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: (value) {
          print(value);
          varname = value;
        },
        maxLines: 1,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
