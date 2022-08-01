import 'package:flutter/material.dart';
import 'package:nyt_mock/constant/asset_path.dart';
import 'package:nyt_mock/ui/article_screen.dart';
import 'package:nyt_mock/ui/shared/app_bar.dart';
import 'package:nyt_mock/util/enum.dart';
import 'package:nyt_mock/util/struct.dart';

import 'search_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final List<Menu> _menu = [Menu('Search', [SubMenu('Search Articles', const SearchScreen())]),
    Menu('Popular', [SubMenu('Most Viewed', const ArticleScreen(type: ArticleType.view), tapIcon),
      SubMenu('Most Shared', const ArticleScreen(type: ArticleType.share), shareIcon),
      SubMenu('Most Emailed', const ArticleScreen(type: ArticleType.email), emailIcon)])];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'NYT', context: context, showLeading: false),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shrinkWrap: true,
        itemCount: _menu.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildMenu(_menu[index]);
        },
      ),
    );
  }

  //widget functions
  Widget _buildMenu(Menu menu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menu.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          for (var item in menu.sub)
            _buildSubMenu(item),
        ],
      ),
    );
  }

  Widget _buildSubMenu(SubMenu menu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => menu.screen),);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.tealAccent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                if (menu.icon != null) ...[
                  Image.asset(menu.icon!, height: 20),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(menu.label,
                      style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_ios, size: 15)
              ],
            )
        ),
      ),
    );
  }
}