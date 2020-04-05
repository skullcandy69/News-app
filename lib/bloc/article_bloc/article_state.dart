import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kal_tak_news/data/models/news_model.dart';


abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {

  List<Articles> articles;

  ArticleLoadedState({@required this.articles});

  @override
  List<Object> get props => [articles];
}

class ArticleErrorState extends ArticleState {

  String message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}