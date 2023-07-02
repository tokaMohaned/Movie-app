import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String? uid;

  Database({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> addMovie({
    required String title,
    required String releaseDate,
    required String overview
  }) async {
    final movieId = FirebaseFirestore.instance.collection("users").doc().id;
    await userCollection.doc(movieId).set({
      'title': title,
      'releaseDate': releaseDate,
      'overview': overview,
    });
  }

}
