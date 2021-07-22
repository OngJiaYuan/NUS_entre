import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:nus_entreprenuership_app/screens/homeScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nus_entreprenuership_app/screens/registrationScreen.dart';
import 'package:nus_entreprenuership_app/services/error_message.dart';
import 'package:nus_entreprenuership_app/shared_widgets/constants.dart';
import 'package:nus_entreprenuership_app/shared_widgets/nes_logo.dart';
import 'package:nus_entreprenuership_app/shared_widgets/roundedButton.dart';

class LoginTextfieldScreen extends StatefulWidget {
  static String id = 'login_text';
  @override
  _LoginTextfieldScreenState createState() => _LoginTextfieldScreenState();
}

class _LoginTextfieldScreenState extends State<LoginTextfieldScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  var errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: nesLogo(),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, MyHomePage.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (error) {
                    print(error);
                    setState(() {
                      showSpinner = false;
                      errorMessage =
                          AuthExceptionHandler.generateExceptionMessage(error);
                      ;
                    });
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(errorMessage.toString()),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(error.toString()),
                                Text('Would you like to try again?'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Try again'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Register?'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegistrationScreen.id);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
