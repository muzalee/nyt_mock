class Article {
  String title;
  String headline;
  String pubDate;
  String publishedDate;

  Article({required this.title, required this.headline, required this.pubDate, required this.publishedDate});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      headline: json['headline'] ==  null ? '' : json['headline']['main'] ?? '',
      pubDate: json['pub_date'] ?? '',
      publishedDate: json['published_date'] ?? '',
    );
  }
}