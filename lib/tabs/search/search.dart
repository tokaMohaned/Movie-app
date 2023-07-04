import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/api/network/remot/api_manager.dart';
import '../../constants/constants.dart';
import '../../models/movie_response.dart';
import '../../screens/movie_details.dart';
import '../../widgets/add_movie.dart';
import '../../widgets/widgets.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String movieName = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          SizedBox(
            height: 35.h,
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                movieName = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          FutureBuilder(
              future: ApiManager.searchOnMovies(movieName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  );
                }
                if (snapshot.data == null) {
                  return Image.asset("assets/images/loading.png");
                }
                MovieResponse search = snapshot.data!;
                return Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String movieId = "${search.results![index].id}";
                      return GestureDetector(
                        onTap: () {
                          nextScreen(context,
                              MovieDetails(movieId: movieId, movie: search.results![index]));
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
                                          "$baseImageUrl/original/${search.results?[index].posterPath}",
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress)),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    AddMovie(result: search.results![index])
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
                                          search.results?[index].title ?? "",
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
                                    "${search.results?[index].releaseDate}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  SizedBox(
                                      width: 200.w,
                                      child: Text(
                                          search.results?[index].overview ?? "",
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
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: const Color(0xFF707070),
                        height: 30.h,
                        thickness: 2,
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
