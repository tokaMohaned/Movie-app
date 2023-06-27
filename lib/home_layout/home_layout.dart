import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/my_app_provider.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "HomeLayout";

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 892),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider(
          create: (context) => MyAppProvider(),
          builder: (context, child) {
            var provider = Provider.of<MyAppProvider>(context);
            return Scaffold(
                body: provider.tabs[provider.index],
                bottomNavigationBar: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Theme.of(context).primaryColor),
                  child: BottomNavigationBar(
                    currentIndex: provider.index,
                    onTap: (value) {
                      provider.onTap(value);
                    },
                    items:  const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: "SEARCH",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.movie),
                        label: "BROWSE",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book),
                        label: "WATCHLIST",
                      ),
                    ],
                  ),
                ));
          },
        );
      }
    );
  }
}
