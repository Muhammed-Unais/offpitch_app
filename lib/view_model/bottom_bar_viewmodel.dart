import 'package:flutter/material.dart';

class BottomBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  onTap(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
