import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/models/movie_model.dart';

class FirebaseFunctions{
  static CollectionReference<MovieWatchListModel> getMovieWatchListCollection() {
    return FirebaseFirestore.instance
        .collection("watchList")
        .withConverter<MovieWatchListModel>(
      fromFirestore: (snapshot, _) => MovieWatchListModel.fromJson(snapshot.data()!),
      toFirestore: (movie, options) => movie.toJson(),
    );
  }

  static Future<void> addMovieToFireStore(MovieWatchListModel movie) {
    var collections = getMovieWatchListCollection();
    var docRef = collections.doc();
    movie.movieId = docRef.id;
    return docRef.set(movie);
  }

  static Stream<QuerySnapshot<MovieWatchListModel>> getMoviesFromFireStore() {
    var collection = getMovieWatchListCollection();
    return collection
        // .orderBy("time", descending: true)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getMovieWatchListCollection().doc(id).delete();
  }


}