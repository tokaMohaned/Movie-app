import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/models/categories_response.dart';
import 'package:untitled1/screens/category_screen.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../../api/network/remot/api_manager.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 76.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Browse Category ",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30.sp)),
          FutureBuilder<CategoriesResponse>(
            future: ApiManager.getCategoriesOfMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const Center(child: CircularProgressIndicator()),
                  ],
                );
              }
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                );
              }
              CategoriesResponse categories = snapshot.data!;
              return Expanded(
                  child: GridView.builder(
                itemCount: categories.genres?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: InkWell(
                      onTap: () {
                        String categoryName =
                            categories.genres?[index].name ?? "";
                        num? categoryId = categories.genres?[index].id;
                        nextScreen(
                            context,
                            CategoryScreen(
                                categoryName: categoryName,
                                categoryId: categoryId!));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/images/categories_bg.png"),
                          Text(
                            "${categories.genres?[index].name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
