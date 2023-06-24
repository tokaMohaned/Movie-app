import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/nav_bar_screens/Browse.dart';
import 'package:untitled1/screens/nav_bar_screens/home_screen.dart';
import 'package:untitled1/screens/nav_bar_screens/search.dart';

import 'nav_bar_screens/watchlist.dart';

class BottomNavgationBar extends StatefulWidget {
  static const String routeName="BottomNavgationBar";

  const BottomNavgationBar({super.key});

  @override
  State<BottomNavgationBar> createState() => _BottomNavgationBarState();
}

class _BottomNavgationBarState extends State<BottomNavgationBar> {
  int index=0;
  List<Widget> tabs=[
    HomeScreen(),
    SearchTab(),
    BrowseTab(),
    Whatchlist(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Stack(children: [
      Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value)
          {
            index=value;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/Home icon.png")),
                label: "Home",
              //backgroundColor: Theme.of(context).yello
            ),

            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/Home icon.png")),
              label: "SEARCH",
              //backgroundColor: Theme.of(context).yello
            ),

            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/Home icon.png")),
              label: "BROWSE",
              //backgroundColor: Theme.of(context).yello
            ),

            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/Home icon.png")),
              label: "WATCHLIST",
              backgroundColor: Theme.of(context).primaryColor
            ),
          ],
        ),
      )
    ],

    );
  }
}
