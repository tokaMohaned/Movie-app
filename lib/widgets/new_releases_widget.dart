import 'package:flutter/material.dart';

import 'movie_added.dart';

class NewReleases extends StatelessWidget {
  const NewReleases({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.asset("assets/images/new_releases.png"),
         const MovieAdded()
      ],
    );
  }
}
