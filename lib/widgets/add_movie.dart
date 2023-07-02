import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../api/network/remot/firebase_finctions.dart';
import '../models/movie_model.dart';
import '../provider/my_app_provider.dart';

class AddMovie extends StatelessWidget {
  var result;
   AddMovie({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return InkWell(
      onTap: () {
        MovieWatchListModel movie = MovieWatchListModel(
          title: result.title,
          overview: result.overview,
          id: result.id,
          releaseDate: result.releaseDate,
          backdropPath: result.backdropPath,
          posterPath: result.posterPath,
          popularity: result.popularity,
          voteAverage: result.voteAverage,
          voteCount: result.voteCount,
          originalLanguage: result.originalLanguage,
          originalTitle: result.originalTitle,
          adult: result.adult,
          video: result.video,
          genreIds: result.genreIds,
           );
        FirebaseFunctions.addMovieToFireStore(movie);
        provider.isMovieAdded = true;
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
