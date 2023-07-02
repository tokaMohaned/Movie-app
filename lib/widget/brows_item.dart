import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/network/api_manager.dart';

import '../model/BrowsModel.dart';

class BrowsItem extends StatelessWidget {
   //Genres genres;
  // int? genresId=genres.id;
  bool? selected;
   BrowsModel? brows_model;
  int? index;
  //var categories=ApiManager.getBrows(genres.id);
  //BrowsItem() ; //BrowsItem(this.genres,this.selected,this.brows_model,this.index);
  //const BrowsItem({super.key});


  Widget build(BuildContext context) {
    return  Container(
      child: Stack(
        children: [
          Image.asset("assets/images/movie image.png"),
          //Text(genres.name),
          Text(brows_model?.genres?.first.name ?? " FDFD",
            textAlign: TextAlign.center,
            style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w100,

          ),),
        // Text(categories as String),
        ],
      ),
    );
  }
}
