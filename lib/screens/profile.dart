import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nus_entreprenuership_app/screens/update_profile.dart';
import 'package:nus_entreprenuership_app/services/firebase_auth_helper.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class profilePage extends StatefulWidget {
  static String id = 'profile';

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final _auth = FirebaseAuth.instance;
  late String description;
  late String sender;
  late String time;
  late String title;
  late String url;

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
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      drawer: nesSideBar(context),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder(
              future: users.doc(loggedInUser?.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("hello");
                }
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                } else {
                  return CircularProgressIndicator();
                }
              }),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileUpdate.id);
                },
                child: Text('Update Profile')),
          )
        ],
      )),
    );
  }

  Widget displayUserInformation(
      BuildContext context, AsyncSnapshot<Object?> snapshot) {
    final authData = snapshot.data;
    return Column(
      children: [],
    );
  }
}
