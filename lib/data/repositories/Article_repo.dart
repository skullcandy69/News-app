import 'dart:convert';
import 'package:kal_tak_news/data/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:kal_tak_news/res/strings.dart';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class Sports implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(AppStrings.cricArticleUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}

class TopHeadlines implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(AppStrings.topArticleUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}

class Economy implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(AppStrings.economy);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
class Health implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(AppStrings.health);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}