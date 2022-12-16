import 'package:flutter/material.dart';

class TabBarViewModel extends ChangeNotifier {
  bool _isExpand = false;
  bool get isExpand => _isExpand;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void isExpanded(bool isExpand) {
    _isExpand = isExpand;
    notifyListeners();
  }

  void index(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }
}
