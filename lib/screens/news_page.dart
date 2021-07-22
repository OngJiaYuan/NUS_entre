import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nus_entreprenuership_app/screens/add_news.dart';
import 'package:nus_entreprenuership_app/screens/chat.dart';
import 'package:nus_entreprenuership_app/screens/homeScreen.dart';
import 'package:nus_entreprenuership_app/shared_widgets/constants.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class newsfeed extends StatefulWidget {
  static const String id = 'news';
  @override
  _newsfeedState createState() => _newsfeedState();
}

class _newsfeedState extends State<newsfeed> {
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
    return Scaffold(
      drawer: nesSideBar(context),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              }),
        ],
        title: Text('NewsList'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, addnews.id);
                },
                child: const Text('Add News'))
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final description = message['description'];
          final sender = message['sender'];
          final time = DateTime.fromMicrosecondsSinceEpoch(
              message['time'].microsecondsSinceEpoch);
          final title = message['title'];
          final url = message['url'];

          final currentUser = loggedInUser?.email;

          final messageBubble = MessageBubble(
              description: description,
              sender: sender,
              time: time,
              title: title,
              url: url);

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.description,
      required this.sender,
      required this.url,
      required this.time,
      required this.title});
  final String description;
  final String sender;
  final String url;
  final DateTime time;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Title: ${title}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Description: ${description}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                launchURL(url);
              },
              child: Text(
                'Url: ${url}',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Author: ${sender}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Date: ${time.toString()}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
