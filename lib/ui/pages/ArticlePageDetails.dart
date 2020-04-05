import 'package:flutter/material.dart';
import 'package:kal_tak_news/data/models/news_model.dart';

class ArticleDetailPage extends StatelessWidget {
  Articles article;

  ArticleDetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Center(child: Text("Kal-Tak")),
        ),
        body: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            article.urlToImage != null
                ? Container(
                  height: 220,
                  child: Image.network(article.urlToImage))
                : Placeholder(strokeWidth: 20,fallbackWidth: 20,fallbackHeight: 200,),
            article.title != null
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      article.title,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                : Container(),
            article.publishedAt != null
                ? Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.all(5.0),
                    child: Text(article.publishedAt),
                  )
                : Container(),
            article.content != null ? Text(article.content) : Container(),
          ],
        ),
      ),
    );
  }
}
