import 'package:flutter/material.dart';

class NavbarIndexProvider extends ChangeNotifier {
  // public var (getters)
  int get currentIndex => _currentIndex;

  // private var
  int _currentIndex = 0;

  // public methods
  void updateIndex(int selectedIndex) {
    _currentIndex = selectedIndex;
    notifyListeners();
  }
}
