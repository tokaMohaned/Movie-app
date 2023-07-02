import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Popular_movie extends StatelessWidget {

  const Popular_movie({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Image.asset("assets/images/movie image.png"),
                Text("movie name"),
                // Column(
                //   //crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children:
                //   [
                //      //            ClipRRect(//Creates a rounded-rectangular clip
                //     //               borderRadius: BorderRadius.only(
                //     //                 topLeft: Radius.circular(12),
                //     //                 topRight: Radius.circular(12),
                //     //               ),
                //     //               child:
                //     //                   //cach network image it is prevent form alot of loading
                //     //                   CachedNetworkImage(
                //     //                     imageUrl: article.urlToImage ?? "",
                //     //                     height: 160,
                //     //                     placeholder: (context, url) => CircularProgressIndicator(),
                //     //                     errorWidget: (context, url, error) => Icon(Icons.error),
                //     //                   ),
                //     //             ),
                //
                //     Image.asset("assets/images/movie image.png"),
                //     // Text("movie name"),
                //     // SizedBox(height: 3,),
                //     // Text("movie details"),
                //
                //   ],
                //
                // ),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: //Text("movie namecccccccccccccc")
                    // ),
            // Positioned(
            // bottom: .5,
            //  left: 1,
            // child: Text('This is the text'),),
                Container(
                    alignment: Alignment.center,
                    child: Text("movie name")),
                )]
            ),
          ),
        ],
      ),
    );
  }
}
