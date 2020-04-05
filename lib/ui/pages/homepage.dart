import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kal_tak_news/bloc/article_bloc/article_bloc.dart';
import 'package:kal_tak_news/ui/pages/headlines.dart';
import 'package:kal_tak_news/data/repositories/Article_repo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
      ),
      home: DefaultTabController(
        length: 4,
        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.lightGreenAccent,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("Exit"),
                                content:
                                    new Text("Are you sure you want to exit?"),
                                elevation: 10,
                                contentTextStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 20),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new FlatButton(
                                      child: new Text("Exit"),
                                      onPressed: () => exit(0)),
                                ],
                              );
                            },
                          );
                        })
                  ],
                  title: Center(child: Text("Kal-Tak")),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Headlines',
                        icon: Icon(Icons.touch_app),
                      ),
                      Tab(
                        text: 'Sports',
                        icon: Icon(Icons.games),
                      ),
                      Tab(
                        text: 'economy',
                        icon: Icon(Icons.attach_money),
                      ),
                      Tab(
                        text: 'health',
                        icon: Icon(Icons.healing),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  BlocProvider(
                    builder: (context) =>
                        ArticleBloc(repository: TopHeadlines()),
                    child: Headlines(),
                  ),
                  BlocProvider(
                    builder: (context) => ArticleBloc(repository: Sports()),
                    child: Headlines(),
                  ),
                  BlocProvider(
                    builder: (context) => ArticleBloc(repository: Economy()),
                    child: Headlines(),
                  ),
                  BlocProvider(
                    builder: (context) => ArticleBloc(repository: Health()),
                    child: Headlines(),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
