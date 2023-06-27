import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/models/top_rated_response.dart';
import 'package:untitled1/screens/movie_details.dart';
import 'package:untitled1/widgets/add_movie.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';


class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w800),
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
                                Image.network(
                                "$baseImageUrl/original/${topRated.results?[index].backdropPath}",
                                  // fit: BoxFit.cover,
                                ),
                                   AddMovie(result: topRated.results![index],)
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
