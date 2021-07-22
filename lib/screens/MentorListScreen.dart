import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nus_entreprenuership_app/shared_widgets/constants.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';

import 'homeScreen.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class MemberList extends StatefulWidget {
  static const String id = 'member_list';
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  final _auth = FirebaseAuth.instance;
  late String Linkedin;
  late String Name;
  late String Telegram;
  late String email;

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
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamed(context, MyHomePage.id);
              }),
        ],
        title: Text('Member List'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[],
              ),
            ),
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
      stream: _firestore.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final Linkedin = message['Linkedin'];
          final Name = message['Name'];
          final Telegram = message['Telegram'];
          final email = message['email'];

          final currentUser = loggedInUser!.email;

          final messageBubble = MessageBubble(
            email: email,
            Linkedin: Linkedin,
            Telegram: Telegram,
            Name: Name,
          );

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
      {required this.Linkedin,
      required this.Name,
      required this.Telegram,
      required this.email});
  final String Linkedin;
  final String Name;
  final String Telegram;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Name: ${Name}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Telegram: ${Telegram}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Email: ${email}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'LinkedIn: ${Linkedin}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
