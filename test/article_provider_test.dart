import 'package:flutter_test/flutter_test.dart';
import 'package:nyt_mock/core/model/article.dart';
import 'package:nyt_mock/ui/article_provider.dart';
import 'package:nyt_mock/util/enum.dart';

void main() {
  late ArticleProvider sut;

  setUp(() {
    sut = ArticleProvider();
  });

  test(
    "getSearchArticle: check loading state, error", () async {

     final future = sut.getArticles('ran', ArticleType.search);
     expect(sut.isLoading, true);
      await future;
     expect(sut.articles, isA<List<Article>>());
     expect(sut.isLoading, false);
     expect(sut.error, false);
    },
  );

  test(
    "getPopularArticle (most viewed): check loading state, error", () async {

      final future = sut.getArticles(null, ArticleType.view);
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, isA<List<Article>>());
      expect(sut.articles.length, 20);
      expect(sut.isLoading, false);
      expect(sut.error, false);
    },
  );

  test(
    "getPopularArticle (most shared): check loading state, error", () async {

      final future = sut.getArticles(null, ArticleType.share);
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, isA<List<Article>>());
      expect(sut.articles.length, 20);
      expect(sut.isLoading, false);
      expect(sut.error, false);
    },
  );

  test(
    "getPopularArticle (most emailed): check loading state, error", () async {

      final future = sut.getArticles(null, ArticleType.email);
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, isA<List<Article>>());
      expect(sut.articles.length, 20);
      expect(sut.isLoading, false);
      expect(sut.error, false);
    },
  );
}