import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/models/top_rated.dart';
import 'package:untitled1/widgets/add_movie.dart';
import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';


class Recommended extends StatefulWidget {
  const Recommended({super.key});

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  Future<List<TopRated>>? topRatedMovies;

  @override
  void initState() {
    topRatedMovies = ApiManager.getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      flex: 3,
      child: Container(
        color: const Color(0xFF282A28),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New Releases",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: FutureBuilder<List<TopRated>>(
                  future: topRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          TopRated topRated = snapshot.data![index];
                          return Stack(
                            children: [
                              Image.network(
                                "$baseImageUrl/original/${topRated.results!.first.id!}",
                                // fit: BoxFit.cover,
                              ),
                              const AddMovie()
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 14.w,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}',style: const TextStyle(color: Colors.white,fontSize: 15),);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
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
