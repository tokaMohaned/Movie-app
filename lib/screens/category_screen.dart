import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/api/network/remot/api_manager.dart';
import 'package:untitled1/models/category_screen_response.dart';
import '../constants/constants.dart';
import '../widgets/add_movie.dart';
import '../widgets/widgets.dart';
import 'movie_details.dart';

class CategoryScreen extends StatelessWidget {
  String categoryName;
  num categoryId;

  CategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 77.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName,
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            FutureBuilder(
                future: ApiManager.getCategoryScreenMovies(genreId: categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    );
                  }
                  CategoryScreenResponse categoryScreen = snapshot.data!;
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                              String movieId = "${categoryScreen.results![index].id}";
                          Results movie = categoryScreen.results![index];
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
                                          "$baseImageUrl/original/${categoryScreen.results?[index].posterPath}",
                                          progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                              Center(
                                                  child: CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress)),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                         AddMovie(result: movie)
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
                                          child: Text(
                                              categoryScreen.results?[index].title ?? "",
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
                                        "${categoryScreen.results?[index].releaseDate}",
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      SizedBox(
                                          width: 200.w,
                                          child: Text(
                                              categoryScreen.results?[index].overview ?? "",
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
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: const Color(0xFF707070),
                            height: 30.h,
                            thickness: 2,
                          );
                        },
                        itemCount: categoryScreen.results!.length),
                  );
                })
          ],
        ),
      ),
    );
  }
}
