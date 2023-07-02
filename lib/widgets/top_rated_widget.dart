import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/top_rated_response.dart';
import 'package:untitled1/screens/movie_details.dart';
import 'package:untitled1/widgets/add_movie.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';
import '../provider/my_app_provider.dart';
import 'movie_added.dart';


class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return  Expanded(
      flex: 2,
      child: Container(
        color: const Color(0xFF282A28),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Top Rated",
                style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: FutureBuilder<TopRatedResponse>(
                  future: ApiManager.getTopRatedMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}',style: const TextStyle(color: Colors.white,fontSize: 15),);
                    }
                    if (snapshot.data == null) {
                      return Image.asset("assets/images/loading.png");
                    }
                    TopRatedResponse topRated = snapshot.data!;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.results!.length,
                        itemBuilder: (BuildContext context, int index) {
                              String movieId = "${topRated.results![index].id}";
                              Results movie = topRated.results![index];
                          return GestureDetector(
                            onTap: (){
                              nextScreen(context, MovieDetails(movieId: movieId, movie: movie));
                            },
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "$baseImageUrl/original/${topRated.results?[index].backdropPath}",
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                ),
                                AddMovie(result: movie)
                                   // AddMovie(result: topRated.results![index],)
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
