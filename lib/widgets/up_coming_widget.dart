import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/api/network/remot/api_manager.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../constants/constants.dart';
import '../models/up_coming_response.dart';
import '../screens/movie_details.dart';
import 'add_movie.dart';

class UpComingWidget extends StatelessWidget {
  const UpComingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: const Color(0xFF282A28),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Up Coming",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: FutureBuilder<UpComingResponse>(
                  future: ApiManager.getUpComingMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      );
                    }
                    if (snapshot.data == null) {
                      return Image.asset("assets/images/loading.png");
                    }
                    UpComingResponse upComing = snapshot.data!;
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.results!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String movieId = "${upComing.results![index].id}";
                        Results movie = upComing.results![index];
                        return GestureDetector(
                          onTap: () {
                            nextScreen(context,
                                MovieDetails(movieId: movieId, movie: movie));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 190,
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "$baseImageUrl/original/${upComing.results?[index].backdropPath }",
                                      // fit: BoxFit.cover,
                                    ),
                                    AddMovie(result: upComing.results![index],)
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
                                        "${upComing.results?[index].voteAverage}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                child: Text(
                                  "${upComing.results?[index].title}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 5.h),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${upComing.results![index].releaseDate}"
                                              .substring(0, 4),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "${upComing.results?[index].originalLanguage}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "${upComing.results?[index].voteCount}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 14.w,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
