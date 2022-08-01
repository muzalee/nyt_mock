import 'package:flutter/material.dart';
import 'package:nyt_mock/core/model/article.dart';
import 'package:nyt_mock/util/enum.dart';

class ListWidget extends StatelessWidget {
  final Article article;
  final ArticleType type;
  const ListWidget({Key? key, required this.article, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type == ArticleType.search ? article.headline : article.title,
              style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: type == ArticleType.search ? Text(article.pubDate.isEmpty ? '-' : article.pubDate.substring(0, 10), style: const TextStyle(fontSize: 13),)
                  : Text(article.publishedDate.isEmpty ? '-' : article.publishedDate.substring(0, 10), style: const TextStyle(fontSize: 13),),
            )
          ],
        )
    );
  }
}
