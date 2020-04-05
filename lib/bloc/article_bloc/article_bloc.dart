import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:kal_tak_news/data/models/news_model.dart';
import 'package:kal_tak_news/data/repositories/Article_repo.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  ArticleRepository repository;

  ArticleBloc({@required this.repository});

  @override
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }

}