import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/models/article_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nus_entreprenuership_app/screens/MentorListScreen.dart';
import 'package:nus_entreprenuership_app/screens/chat.dart';
import 'package:nus_entreprenuership_app/screens/news_page.dart';
import 'package:nus_entreprenuership_app/screens/profile.dart';
import 'package:nus_entreprenuership_app/screens/registrationScreen.dart';
import 'package:nus_entreprenuership_app/screens/youtube_channel.dart';
import 'package:nus_entreprenuership_app/services/news_article_api.dart';
import 'package:nus_entreprenuership_app/shared_widgets/bottom_navigation_bar.dart';
import 'package:nus_entreprenuership_app/shared_widgets/customListTile.dart';
import 'package:nus_entreprenuership_app/shared_widgets/nes_logo.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class MyHomePage extends StatefulWidget {
  static String id = 'home_page';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  int selectedIndex = 0;

  List screens = [
    newsfeed(),
    YoutubeScreen(),
    MemberList(),
    profilePage(),
  ];

  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  ApiService client = ApiService();
  GlobalKey<ScaffoldState> _key = GlobalKey();

  Widget _icon(IconData icon, {Color color = Colors.blue}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: Theme.of(context).backgroundColor,
        //boxShadow: AppTheme.shadow
      ),
      child: InkWell(
        onTap: () {
          _key.currentState!.openDrawer();
        },
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }

  bool isHomePageSelected = true;
  Widget _appBar() {
    return Container(
      //padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.menu, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        key: _key,
        appBar: AppBar(
          leading: _appBar(),
          title: Text("Home"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                },
                icon: Icon(Icons.chat))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(child: Container(height: 300, width: 300, child: nesLogo())),
            Center(child: Text('Welcome ${loggedInUser?.uid}'))
          ],
        ),
        drawer: nesSideBar(context),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.blue[900],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Education',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Connect',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex,
            backgroundColor: Colors.white,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            }));
  }
}
