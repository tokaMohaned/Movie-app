import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tabs/browse/browse.dart';
import '../tabs/home/home_tab.dart';
import '../tabs/search/search.dart';
import '../tabs/watch_list/watch_list.dart';

class MyAppProvider extends ChangeNotifier {
  int index = 0;
  bool isMovieAdded = false;

  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    const Watchlist(),
  ];

  onTap(value) {
    index = value;
    notifyListeners();
  }
}
