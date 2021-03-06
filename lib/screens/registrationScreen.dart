import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nus_entreprenuership_app/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nus_entreprenuership_app/screens/profile_image_upload.dart';
import 'package:nus_entreprenuership_app/services/error_message.dart';
import 'package:nus_entreprenuership_app/shared_widgets/constants.dart';
import 'package:nus_entreprenuership_app/shared_widgets/nes_logo.dart';
import 'package:nus_entreprenuership_app/shared_widgets/roundedButton.dart';
import 'package:firebase_core/firebase_core.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String name;
  late String email;
  late String password;
  late String password2;
  late String telegram;
  late String linkedin;
  late String errorMessage;
  late bool mentor = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                    tag: 'logo',
                    child: Padding(
                        padding: const EdgeInsets.all(80.0), child: nesLogo())),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Full Name'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                  validator: (value) {
                    if (value == null || !value.contains('@'))
                      return 'Please enter a valid Email address';
                    return null;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                  validator: (value) {
                    if (value == null || value.length <= 6)
                      return 'Please enter a 7 character password';
                    return null;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password2 = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Re-Enter your password'),
                  validator: (value) {
                    if (value == null || value.length <= 6)
                      return 'Please enter a 7 character password';
                    else if (password2 != password)
                      return 'Password does not match';
                    return null;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    telegram = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your telegram'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    linkedin = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your linkedin'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text('Are you a mentor'),
                    SizedBox(
                      width: 150,
                    ),
                    Switch(
                        activeTrackColor: Colors.lightBlue,
                        activeColor: Colors.blueAccent,
                        value: mentor,
                        onChanged: (value) {
                          setState(() {
                            mentor = value;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    title: 'Register',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          _firestore
                              .collection('user')
                              .doc(newUser.user!.uid)
                              .set({
                            'email': email,
                            'Linkedin': linkedin,
                            'Name': name,
                            'Telegram': telegram,
                            'id': newUser.user!.uid,
                            'mentor': mentor,
                          });
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
                              AuthExceptionHandler.generateExceptionMessage(
                                  error);
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
                              ],
                            );
                          },
                        );
                      }
                      ;
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
