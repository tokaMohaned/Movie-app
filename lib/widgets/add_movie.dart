import 'package:flutter/material.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../api/network/remot/firebase_finctions.dart';
import '../models/movie_model.dart';

class AddMovie extends StatefulWidget {
  var result;

  AddMovie({Key? key, required this.result}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {

  bool isAdded = false;

  @override
  void initState() {
    getMovieFromWatchList();
    super.initState();
  }

  getMovieFromWatchList() {
    FirebaseFunctions.searchMovieById(widget.result.id.toString()).then((value) {
      setState(() {
        isAdded = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isAdded == false) {
          MovieWatchListModel movie = MovieWatchListModel(
            title: widget.result.title,
            overview: widget.result.overview,
            id: widget.result.id,
            releaseDate: widget.result.releaseDate,
            backdropPath: widget.result.backdropPath,
            posterPath: widget.result.posterPath,
            popularity: widget.result.popularity,
            voteAverage: widget.result.voteAverage,
            voteCount: widget.result.voteCount,
            originalLanguage: widget.result.originalLanguage,
            originalTitle: widget.result.originalTitle,
            adult: widget.result.adult,
            video: widget.result.video,
            genreIds: widget.result.genreIds,
          );
          FirebaseFunctions.addMovieToFireStore(movie);
          showSnackBar(
            color: Colors.green,
            context: context,
            text: 'Movie has been added to watchList',
          );
        } else {
          FirebaseFunctions.deleteTask(widget.result.id.toString());
          showSnackBar(
            color: Colors.redAccent,
            context: context,
            text: 'Movie has been removed to watchList',
          );
        }
        isAdded = !isAdded;
        setState(() {});
      },
      child: isAdded
          ? const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.bookmark,
                  color: Color.fromRGBO(215, 158, 51, 70),
                  size: 50,
                ),
                Icon(Icons.check, color: Colors.white, size: 20),
              ],
            )
          : const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.bookmark,
                  color: Color.fromRGBO(81, 78, 75, 70),
                  size: 50,
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
    );
  }
}
