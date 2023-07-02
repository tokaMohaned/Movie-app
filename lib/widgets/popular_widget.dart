import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/my_app_provider.dart';
import 'package:untitled1/widgets/widgets.dart';

import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';
import '../models/popular_response.dart';
import '../screens/movie_details.dart';
import 'add_movie.dart';
import 'movie_added.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return FutureBuilder<PopularResponse>(
      future: ApiManager.getPopular(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              const Text("Something went wrong"),
              TextButton(
                onPressed: () {},
                child: const Text("Try Again"),
              )
            ],
          );
        }
        if (snapshot.data == null) {
          return Image.asset("assets/images/loading.png");
        }
        PopularResponse movie = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Text("Popular", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),),
            ),
            CarouselSlider.builder(
              itemCount: movie.results!.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                String movieId = "${movie.results![itemIndex].id}";
                Results result = movie.results![itemIndex];
                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SizedBox(
                      height: 280.w,
                      child: GestureDetector(
                        onTap: () {
                          nextScreen(context,
                              MovieDetails(movieId: movieId, movie: result));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "$baseImageUrl/original/${movie.results![itemIndex].backdropPath!}",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                            const Icon(
                              Icons.play_circle,
                              size: 90,
                              color: Color.fromRGBO(255, 255, 255, 120),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150.h,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 21.w, vertical: 2.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      "$baseImageUrl/original/${movie.results![itemIndex].posterPath!}",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress)),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                 AddMovie(result: movie.results![itemIndex])
                              ],
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: Text(
                                    movie.results![itemIndex].title!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      movie.results![itemIndex].releaseDate!,
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                      size: 13,
                                    ),
                                    Text(
                                      movie.results![itemIndex].voteAverage!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
