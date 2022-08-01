import 'package:flutter/material.dart';
import 'package:nyt_mock/ui/shared/app_bar.dart';
import 'package:nyt_mock/util/enum.dart';
import 'package:provider/provider.dart';

import 'article_provider.dart';
import 'widget/list_widget.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleType type;
  final String? search;
  const ArticleScreen({Key? key, required this.type, this.search}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late ArticleProvider _provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((duration) {
      Future.microtask(() => _provider.getArticles('', widget.type),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Articles', context: context),
      body: ChangeNotifierProvider(
        create: (_) => ArticleProvider(),
        child: Consumer<ArticleProvider>(
          builder: (context, provider, child) {
            _provider = provider;
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () {
                  return provider.refresh();
                },
                child: _provider.error ? const Center(
                  child: Text('An Error Occurred. Please Try Again'),
                ) : _provider.articles.isEmpty ? const Center(
                  child: Text('No Data'),
                ) : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: provider.scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          itemCount: provider.articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListWidget(article: provider.articles[index], type: widget.type);
                          }),
                    ),
                    if (provider.loadMore) ...[
                      const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ],
                )
              );
            }
          },
        ),
      ),
    );
  }
}