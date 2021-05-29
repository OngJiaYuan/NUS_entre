import 'package:flutter/material.dart';
import 'package:nus_entreprenuership_app/models/article_model.dart';

Widget customListTile(Article article) {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        article.urlToImage != null
            ? Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              )
            : Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Question_mark_%28black%29.svg/200px-Question_mark_%28black%29.svg.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            article.source.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          article.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        )
      ],
    ),
  );
}
