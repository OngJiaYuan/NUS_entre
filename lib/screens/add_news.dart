import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nus_entreprenuership_app/screens/news_page.dart';
import 'package:nus_entreprenuership_app/shared_widgets/constants.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';

import 'homeScreen.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class addnews extends StatefulWidget {
  static String id = 'addnews';
  @override
  _addnewsState createState() => _addnewsState();
}

class _addnewsState extends State<addnews> {
  final _auth = FirebaseAuth.instance;
  late String title;
  late String description;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add News"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamed(context, MyHomePage.id);
              }),
        ],
      ),
      drawer: nesSideBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Title'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    url = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Url'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLines: 10,
                  decoration:
                      InputDecoration.collapsed(hintText: 'Description'),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'Are you sure of posting this news/announcement'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  if (loggedInUser != null) {
                                    print('hey');
                                    print(description);
                                    print(title);
                                    print(loggedInUser?.uid);
                                    print(url);
                                    print(FieldValue.serverTimestamp());
                                    _firestore.collection('news').add({
                                      'description': description,
                                      'title': title,
                                      'sender': loggedInUser?.uid,
                                      'url': url,
                                      'time': FieldValue.serverTimestamp()
                                    });
                                    Navigator.pushNamed(context, newsfeed.id);
                                  } else {
                                    print('hi');
                                  }
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Post'))
              ]),
        ),
      ),
    );
    ;
  }
}
