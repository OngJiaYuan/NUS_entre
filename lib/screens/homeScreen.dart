import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/models/article_model.dart';
import 'package:nus_entreprenuership_app/services/news_article_api.dart';
import 'package:nus_entreprenuership_app/shared_widgets/customListTile.dart';
import 'package:nus_entreprenuership_app/shared_widgets/sideBar.dart';

class MyHomePage extends StatefulWidget {
  static String id = 'home_page';
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          leading: _appBar(),
          title: Text("Home"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                  itemCount: articles!.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index]));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        drawer: nesSideBar(context));
  }
}
