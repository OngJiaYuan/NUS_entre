import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/screens/homeScreen.dart';
import 'package:nus_entreprenuership_app/screens/registrationScreen.dart';
import 'package:nus_entreprenuership_app/services/password.dart';

class LoginTextfieldScreen extends StatefulWidget {
  static String id = 'login_text';
  @override
  _LoginTextfieldScreenState createState() => _LoginTextfieldScreenState();
}

class _LoginTextfieldScreenState extends State<LoginTextfieldScreen> {
  late String _password;
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 190),
                child: _nesLogo(width: width, height: height),
              ),
              Padding(
                padding: EdgeInsets.only(top: 64),
                child: _textField(
                    width: width,
                    labelText: 'Username',
                    varname: 'username',
                    obscure: false),
              ),
              Container(
                width: 320,
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: PasswordField(
                    fieldKey: _passwordFieldKey,
                    helperText: 'No more than 8 characters.',
                    labelText: 'Password *',
                    onFieldSubmitted: (String value) {
                      setState(() {
                        this._password = value;
                      });
                    },
                    validator: (String? value) {},
                    onSaved: (String? newValue) {},
                    hintText: '  ',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: _backAndLoginRow(
                  width: width,
                  backTap: () {
                    Navigator.pop(context);
                  },
                  loginPressed: () {
                    print('press');
                    Navigator.pushNamed(context, MyHomePage.id);
                  },
                  registerPressed: () {
                    Navigator.pushNamed(context, registrationScreen.id);
                  },
                ),
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

Widget _textField(
        {required double width,
        required String labelText,
        required String varname,
        required bool obscure}) =>
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

Widget _loginButton({required double width, required onPressed}) => Container(
      width: width * 0.25,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          'LOGIN',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget _backGesture({required onTap}) => GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Text(
        'back',
        style: TextStyle(color: Colors.blue),
      ),
    );

Widget _backAndLoginRow(
        {required double width,
        required Function backTap,
        required Function loginPressed,
        required Function registerPressed}) =>
    Container(
      width: width * 0.75,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _backGesture(onTap: backTap),
              _loginButton(width: width, onPressed: loginPressed),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: _registerButton(onPressed: registerPressed),
          )
        ],
      ),
    );

Widget _registerButton({onPressed}) => Container(
      height: 20,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          'do not have any account? Register now.',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black,
          ),
        ),
      ),
    );
