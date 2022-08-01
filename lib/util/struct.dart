import 'package:flutter/material.dart';

class Menu {
  String label;
  List<SubMenu> sub;

  Menu(this.label, this.sub);
}

class SubMenu {
  String label;
  Widget screen;
  String? icon;

  SubMenu(this.label, this.screen, [this.icon]);
}