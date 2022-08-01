import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nyt_mock/ui/shared/app_bar.dart';
import 'package:nyt_mock/util/enum.dart';
import 'package:provider/provider.dart';

import 'article_screen.dart';
import 'search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Search', context: context),
      body: ChangeNotifierProvider(
        create: (_) => SearchProvider(),
        child: Consumer<SearchProvider>(
          builder: (context, provider, child) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: provider.error ? Colors.red : Colors.grey),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 0.0),
                                color: Color.fromRGBO(0, 0, 0, 0.2)
                            ),
                          ]
                      ),
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(CupertinoIcons.doc_text_search, color: Colors.teal)
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontWeight: FontWeight.w300),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                                  hintText: 'Search articles here...',
                                  hintStyle: TextStyle(fontWeight: FontWeight.w300)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Colors.teal
                      ),
                      child: const Text('Search', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        if (provider.validate(_controller.text)) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleScreen(type: ArticleType.search, search: _controller.text.trimRight())));
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Search value cannot be empty!'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}