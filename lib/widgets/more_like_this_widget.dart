import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/models/similar_response.dart';

import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';
import 'add_movie.dart';

class MoreLikeThisWidget extends StatelessWidget {
  const MoreLikeThisWidget({super.key});
  @override
  Widget build(BuildContext context) {
    var similar = ModalRoute.of(context)?.settings.arguments as String;
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
              "More Like This",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: FutureBuilder<SimilarResponse>(
                future: ApiManager.getSimilarMovies(similar),
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
                  SimilarResponse similar = snapshot.data!;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 190,
                            child: Stack(
                              children: [
                                Image.network(
                                  "$baseImageUrl/original/${similar.results?[index].backdropPath}",
                                  // fit: BoxFit.cover,
                                ),
                                const AddMovie()
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.amberAccent,size: 15,),
                                  SizedBox(width: 8.w),
                                  Text("${similar.results?[index].voteAverage}",style:  TextStyle(color: Colors.white,fontSize: 12.sp),)
                                ],
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                            child: Text("${similar.results?[index].title}",style:  TextStyle(color: Colors.white,fontSize: 12.sp),),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                              child: Row(
                                children: [
                                  Text("${similar.results![index].releaseDate}".substring(0,4),style:  TextStyle(color: Colors.white,fontSize: 12.sp)),
                                  SizedBox(width: 8.w),
                                  Text("${similar.results?[index].originalLanguage}",style:  TextStyle(color: Colors.white,fontSize: 12.sp),),
                                  SizedBox(width: 8.w),
                                  Text("${similar.results?[index].voteCount}",style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                                ],
                              )
                          ),
                        ],
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
