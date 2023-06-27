import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tabs/browse/browse.dart';
import '../tabs/home/home_tab.dart';
import '../tabs/search/search.dart';
import '../tabs/watch_list/watch_list.dart';

class MyAppProvider extends ChangeNotifier {
  int index = 0;
  List<dynamic> watchList = [];
  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    const Watchlist(),
  ];

  late SharedPreferences _prefs;

  onTap(value) {
    index = value;
    notifyListeners();
  }

  addWatchList(dynamic result) async {
    watchList.add(result);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> watchListString = watchList.map((movie) => jsonEncode(movie.toJson())).toList();
    prefs.setStringList('watch_list', watchListString);
    notifyListeners();
  }


  removeWatchList(dynamic result) {
    watchList.remove(result);
    notifyListeners();
  }

  bool isMovieInWatchList(dynamic movie) {
    return watchList.contains(movie);
  }

}
