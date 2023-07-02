import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/api/network/remot/api_manager.dart';
import 'package:untitled1/models/similar_response.dart';
import 'package:untitled1/screens/movie_details.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../constants/constants.dart';
import '../provider/my_app_provider.dart';
import 'add_movie.dart';
import 'movie_added.dart';

class MoreLikeThisWidget extends StatelessWidget {
  String? movieId;

  MoreLikeThisWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return FutureBuilder(
      future: ApiManager.getSimilarMovies(movieId!),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Try Again"),
                )
              ],
            ),
          );
        }
        SimilarResponse similar = snapshot.data!;
        return Expanded(
          flex: 3,
          child: Container(
            color: const Color(0xFF282A28),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "More Like This",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Expanded(
                      child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: similar.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Results movie = similar.results![index];
                      return GestureDetector(
                        onTap: () {
                          nextScreenReplace(context,
                              MovieDetails(movieId: movieId, movie: movie));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 190,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$baseImageUrl/original/${similar.results?[index].backdropPath}",
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  ),
                                   AddMovie(result: similar.results?[index])
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                      size: 15,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "${similar.results?[index].voteAverage}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              child: Text(
                                "${similar.results?[index].title}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                child: Row(
                                  children: [
                                    Text(
                                        "${similar.results![index].releaseDate}"
                                            .substring(0, 4),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp)),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "${similar.results?[index].originalLanguage}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "${similar.results?[index].voteCount}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 18.w,
                      );
                    },
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
