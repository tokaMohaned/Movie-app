import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/network/remot/api_manager.dart';
import '../models/latest_model.dart';

class NewReleaseWidget extends StatefulWidget {
  const NewReleaseWidget({super.key});

  @override
  _NewReleaseWidgetState createState() => _NewReleaseWidgetState();
}

class _NewReleaseWidgetState extends State<NewReleaseWidget> {
  Future<List<LatestModel>>? latestMovies;

  @override
  void initState() {
    super.initState();
    latestMovies = ApiManager.getLatestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
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
                child: FutureBuilder<List<LatestModel>>(
                  future: latestMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          LatestModel movie = snapshot.data![index];
                          return Text(movie.title!);
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