import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/widgets/add_movie.dart';
import '../../api/network/remot/firebase_finctions.dart';
import '../../constants/constants.dart';
import '../../models/movie_model.dart';
import '../../screens/movie_details.dart';
import '../../widgets/widgets.dart';

class Watchlist extends StatelessWidget {
  static const String routeName = "Watchlist";

  const Watchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 90.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Watchlist",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.w900),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFunctions.getMoviesFromFireStore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            Text("Something went wrong",
                                style: GoogleFonts.novaSquare(
                                    color: Colors.white)),
                            Text("Error: ${snapshot.error}",
                                style: GoogleFonts.novaSquare(
                                    color: Colors.white)),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Try again",
                                  style: GoogleFonts.novaSquare(),
                                ))
                          ],
                        ),
                      );
                    }
                    List<MovieWatchListModel> movies =
                        snapshot.data?.docs.map((doc) => doc.data()).toList() ??
                            [];
                    if (movies.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Center(
                            child: Text(
                              "No Movies Yet",
                              style: GoogleFonts.novaSquare(
                                  fontSize: 30.sp, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        String movieId = movies[index].id.toString();
                        MovieWatchListModel movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            nextScreen(context,
                                MovieDetails(movieId: movieId, movie: movie));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150.h,
                                  child: Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "$baseImageUrl/original/${movies[index].posterPath}",
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress)),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                              InkWell(
                                onTap: () {
                                    FirebaseFunctions.deleteTask(movieId);
                                    showSnackBar(
                                      color: Colors.redAccent,
                                      context: context,
                                      text: 'Movie has been removed to watchList',
                                    );
                                },
                                child: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Color.fromRGBO(215, 158, 51, 70),
                                      size: 50,
                                    ),
                                    Icon(Icons.check, color: Colors.white, size: 20),
                                  ],
                                ),
                              )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 200.w,
                                        child: Text(movies[index].title ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400))),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "${movies[index].releaseDate}",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    SizedBox(
                                        width: 200.w,
                                        child: Text(
                                            movies[index].overview ?? "",
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: movies.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                    );
                  })),
        ],
      ),
    );
  }
}
