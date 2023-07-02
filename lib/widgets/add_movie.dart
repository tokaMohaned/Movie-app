import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../api/network/remot/database.dart';
import '../provider/my_app_provider.dart';

class AddMovie extends StatelessWidget {
  var result;
   AddMovie({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context);
    return GestureDetector(
      onTap: () {
        // String movieId = result.movieId;
        String movieTitle = result.title;
        String releaseDate = result.releaseDate;
        String overview = result.overview;
        Database().addMovie(title: movieTitle, releaseDate: releaseDate, overview: overview,);
        // provider.addWatchList(result);
        showSnackBar(color: Colors.green, context: context, text: 'Movie has been added to watchList',);
      },
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.bookmark, color: Color.fromRGBO(81, 78, 75, 70), size: 50,),
          Icon(Icons.add, color: Colors.white, size: 20,),
        ],
      ),
    );
  }
}
