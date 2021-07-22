import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nus_entreprenuership_app/screens/profile.dart';
import 'package:nus_entreprenuership_app/screens/profile_image_upload.dart';
import 'package:nus_entreprenuership_app/services/error_message.dart';
import 'package:nus_entreprenuership_app/shared_widgets/constants.dart';
import 'package:nus_entreprenuership_app/shared_widgets/nes_logo.dart';
import 'package:nus_entreprenuership_app/shared_widgets/roundedButton.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ProfileUpdate extends StatefulWidget {
  static String id = 'update_profile';
  @override
  _ProfileUpdatState createState() => _ProfileUpdatState();
}

class _ProfileUpdatState extends State<ProfileUpdate> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String name;
  late String telegram;
  late String linkedin;
  late String errorMessage;
  late bool mentor = true;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

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
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    title: 'Update',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        if (loggedInUser != null) {
                          print(_auth.currentUser!.uid);
                          print(linkedin);
                          print(name);
                          print(telegram);
                          _firestore
                              .collection('user')
                              .doc(_auth.currentUser!.uid)
                              .update({
                            'Linkedin': linkedin,
                            'Name': name,
                            'Telegram': telegram
                          });
                        }

                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.pushNamed(context, profilePage.id);
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
