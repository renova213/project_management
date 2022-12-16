import 'package:flutter/cupertino.dart';

import '../views/home/home_screen.dart';
import '../views/profile/profile_screen.dart';

class BotnavbarViewModel extends ChangeNotifier {
  final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  List<Widget> get pages => _pages;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
