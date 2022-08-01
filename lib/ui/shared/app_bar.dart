import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final BuildContext context;
  final Color? titleColor;
  final Function()? leadingOnPressed;
  final bool showLeading;

  const CustomAppBar({Key? key, this.title, required this.context, this.titleColor,
    this.leadingOnPressed, this.showLeading = true}) : super(key: key);

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.tealAccent,
      elevation: 0.0,
      titleSpacing: 0,
      leading: showLeading ? const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20) : null,
      title: Padding(
        padding: EdgeInsets.only(left: showLeading ? 0 : 20),
        child: Text(title ?? '', style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}