import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kal_tak_news/bloc/article_bloc/article_bloc.dart';
import 'package:kal_tak_news/bloc/article_bloc/article_event.dart';
import 'package:kal_tak_news/bloc/article_bloc/article_state.dart';
import 'package:kal_tak_news/data/models/news_model.dart';
import 'package:kal_tak_news/ui/pages/ArticlePageDetails.dart';
import 'package:kal_tak_news/ui/pages/about.dart';

class Headlines extends StatefulWidget {
  @override
  _HeadlinesState createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await new Future.delayed(new Duration(seconds: 3));
        articleBloc.add(FetchArticlesEvent());
      },
      child: Container(
        child: BlocListener<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticleInitialState) {
                return buildLoading();
              } else if (state is ArticleLoadingState) {
                return buildLoading();
              } else if (state is ArticleLoadedState) {
                return buildArticleList(state.articles);
              } else if (state is ArticleErrorState) {
                return buildErrorUi(state.message);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      dragStartBehavior: DragStartBehavior.down,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: articles[pos].urlToImage != null
                  ? ClipRRect(
                      child: Image.network(
                        articles[pos].urlToImage,
                        fit: BoxFit.cover,
                        height: 70.0,
                        width: 70.0,
                      ),
                    )
                  : CircularProgressIndicator(),
              title: Text(articles[pos].title),
              subtitle: Text(articles[pos].publishedAt),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }

  void navigateToAoutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
}
