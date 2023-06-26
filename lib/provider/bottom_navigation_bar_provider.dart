import 'package:flutter/material.dart';
import '../tabs/browse/browse.dart';
import '../tabs/home/home_tab.dart';
import '../tabs/search/search.dart';
import '../tabs/watch_list/watch_list.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> tabs=[
     HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    const Whatchlist(),
  ];
  onTap(value){
    index = value;
    notifyListeners();
  }
}