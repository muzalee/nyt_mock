import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool _error = false;

   bool get error => _error;

  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  bool validate(String value) {
    if (value.trim().isEmpty) {
      error = true;
      return false;
    }

    error = false;
    return true;
  }
}