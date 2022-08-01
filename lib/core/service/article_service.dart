import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:nyt_mock/core/model/article.dart';
import 'package:nyt_mock/util/enum.dart';

class ArticleService {
  final String baseUrl = "https://api.nytimes.com/svc/";

  Future<List<Article>> getSearch(String search, int page) async {
    try {
      Response res = await get(Uri.parse(baseUrl + 'search/v2/articlesearch.json?q=$search&page=$page&api-key=X1xeGqyvw0hE6pZXdwvJBUri55aGcBQA'));

      log('Response: ${res.body}');

      if (res.statusCode == 200 && jsonDecode(res.body) != null) {
        Map<String, dynamic> map = Map.castFrom(json.decode(res.body));

        List<Article> list = map['response']['docs'] == null ? [] : List<Article>.from(map['response']['docs'].map((x) => Article.fromJson(x)));

        return list;
      } else {
        throw "An error occurred";
      }
    } catch (e) {
      log("Catch Error: [$e]");
      throw "An error occurred";
    }
  }

  Future<List<Article>> getPopular(ArticleType type) async {
    String path = '';

    switch (type) {
      case ArticleType.search:
        break;
      case ArticleType.view:
        path = 'mostpopular/v2/viewed/7.json';
        break;
      case ArticleType.share:
        path = 'mostpopular/v2/shared/1/facebook.json';
        break;
      case ArticleType.email:
        path = 'mostpopular/v2/emailed/1.json';
        break;
    }
    try {
      Response res = await get(Uri.parse(baseUrl + path +'?api-key=X1xeGqyvw0hE6pZXdwvJBUri55aGcBQA'));

      log('Response: ${res.body}');

      if (res.statusCode == 200 && jsonDecode(res.body) != null) {
        Map<String, dynamic> map = Map.castFrom(json.decode(res.body));

        List<Article> list = map['results'] == null ? [] : List<Article>.from(map['results'].map((x) => Article.fromJson(x)));

        return list;
      } else {
        throw "An error occurred";
      }
    } catch (e) {
      log("Catch Error: [$e]");
      throw "An error occurred";
    }
  }
}