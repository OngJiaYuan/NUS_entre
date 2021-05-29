import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/screens/login_textfield_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.25],
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 190),
                child: _nesLogo(width: width, height: height),
              ),
              Padding(
                padding: EdgeInsets.only(top: 128),
                child: _loginButton(
                  width: width,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginTextfieldScreen()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: _registerButton(width: width, onPressed: null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _nesLogo({required double width, required double height}) => Container(
      width: width * 0.65,
      height: height * 0.40,
      child: Image.asset(
        'asset/nes_logo.png',
        fit: BoxFit.fill,
      ),
    );

Widget _loginButton({required double width, required onPressed}) => Container(
      width: width * 0.65,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,


        child: Text(
          'LOGIN',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget _registerButton({required double width, required onPressed}) => Container(
      width: width * 0.65,
      height: 40,
      child: ElevatedButton(

        onPressed: onPressed,

        child: Text(
          'REGISTER',
          style: TextStyle(color: Colors.black),
        ),

      ),
    );
