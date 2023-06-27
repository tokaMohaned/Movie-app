import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../provider/my_app_provider.dart';
import '../../widgets/movie_added.dart';

class Watchlist extends StatelessWidget {
  static const String routeName = "Watchlist";

  const Watchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context);

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
            child: ListView.separated(
              itemCount: provider.watchList.length,
              itemBuilder: (context, index) {
                var movie = provider.watchList[index];
                if (provider.watchList.isEmpty) {
                  return Center(
                    child: Text(
                      "Add Movies",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 150.h,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            CachedNetworkImage(
                              imageUrl: "$baseImageUrl/original/${movie.posterPath!}",
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                            MovieAdded(
                              result: movie,
                            ),
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
                              child: Text(movie.title ?? "",
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
                            "${movie.releaseDate}".substring(0, 4),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          SizedBox(
                              width: 200.w,
                              child: Text(movie.overview ?? "",
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600))),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: const Color(0xFF707070),
                  height: 30.h,
                  thickness: 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
