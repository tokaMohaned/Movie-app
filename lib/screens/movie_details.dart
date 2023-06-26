import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/api/network/remot/api_manager.dart';

import '../constants/constants.dart';
import '../models/popular_response.dart';
import '../widgets/add_movie.dart';
import '../widgets/more_like_this_widget.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = "MovieDetails";

  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getPopular(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        PopularResponse movie = snapshot.data!;
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    "$baseImageUrl/original/${movie.results!.first.backdropPath!}",
                    fit: BoxFit.cover,
                  ),
                  const Icon(
                    Icons.play_circle,
                    size: 90,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Text(
                  movie.results!.first.title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                child: Row(
                  children: [
                    Text(
                      movie.results!.first.releaseDate!,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      width: 8.h,
                    ),
                    Text(
                      movie.results!.first.voteAverage!.toString(),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 220,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Image.network(
                            "$baseImageUrl/original/${movie.results!.first.posterPath!}",
                            // fit: BoxFit.cover,
                          ),
                          const AddMovie(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.h,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: Colors.white60, width: 2)),
                            child: const Text(
                              "Type",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                              child: Text("${movie.results!.first.overview}",
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white))),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                                size: 20,
                              ),
                              SizedBox(width: 10.h),
                              Text("${movie.results!.first.voteAverage}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const MoreLikeThisWidget()
            ],
          ),
        );
      },
    );
  }
}
