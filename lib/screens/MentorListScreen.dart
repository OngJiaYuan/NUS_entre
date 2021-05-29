import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';

class MentorListScreen extends StatefulWidget {
  MentorListScreen({ Key? key, required this.title}) : super(key: key);

  final String title;
  static String id = 'mentor_list';

  @override
  _MentorListScreenState createState() => _MentorListScreenState();
}

class _MentorListScreenState extends State<MentorListScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: _appBar(),
        title: Text("Mentor List Screen"),
        centerTitle: true,
      ),
      drawer: nesSideBar(context),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Text('image of mentor'),
              title: Text('Name of mentor'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              leading: Text('image of mentor'),
              title: Text('Name of mentor'),
              trailing: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
    );
  }
}
