import 'package:flutter/material.dart';
import 'package:nyt_mock/core/model/article.dart';
import 'package:nyt_mock/core/service/article_service.dart';
import 'package:nyt_mock/util/enum.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = true;
  bool _loadMore = false;
  bool _error = false;

  int _page = 0;
  ArticleType _type = ArticleType.search;
  String _search = '';

  late ScrollController _scrollController;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get loadMore => _loadMore;
  bool get error => _error;
  ScrollController get scrollController => _scrollController;

  set articles(List<Article> value) {
    _articles = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set loadMore(bool value) {
    _loadMore = value;
    notifyListeners();
  }

  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  Future<void> getArticles(String? search, ArticleType type) async {
    isLoading = true;
    _type = type;
    _search = search ?? '';

    ArticleService service = ArticleService();
    try {
      if (type == ArticleType.search) {
        List<Article> list = await service.getSearch(search ?? '', _page);

        articles = list;

        if (list.length == 10) {
          _page++;
        }
      } else {
        List<Article> list = await service.getPopular(type);

        articles = list;
      }

      error = false;
    } catch (e) {
      error = true;
    } finally {
      isLoading = false;
    }

    _scrollController = ScrollController()..addListener(getMore);
  }

  Future<void> getMore() async {
    if (_type != ArticleType.search) return;
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_loadMore) {

      loadMore = true;

      ArticleService service = ArticleService();
      try {
        if (_type == ArticleType.search) {
          List<Article> list = await service.getSearch(_search, _page);

          articles.addAll(list);

          if (list.length == 10) {
            _page++;
          }
        }

        error = false;
      } catch (e) {
        error = true;
      } finally {
        loadMore = false;
      }
    }
  }

  Future<void> refresh() async {
    _page = 0;
    error = false;
    await getArticles(_search, _type);
  }
}