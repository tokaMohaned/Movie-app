
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/network/api_manager.dart';

import '../../model/BrowsModel.dart';
import '../../widget/brows_item.dart';

class BrowseTab extends StatefulWidget {
   Function? onBrowsSelect;
   List<Genres>? geners;
 // BrowseTab(this.onBrowsSelect, this.geners);

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  int selectedIndex=0;
 // var browes=Brows_model.fromJson(json);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text("Browse Category")),
        FutureBuilder<BrowsModel>(
          future: ApiManager.getBrows(),
          builder: (context,snapshot)
              //BuildContext context,
            //  AsyncSnapshot<dynamic> snapshot)
              {
                if(snapshot.connectionState== ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                if(snapshot.hasError)
                  {
                    print(snapshot.error);
                    return Center(
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(child: Text("somthing went worng")),
                          Center(child: TextButton(onPressed: () {}, child: Text("tray agian"))),
                        ],
                      ),
                    );

                  }
               // if(snapshot.data?.genres)
                var categoryData=snapshot.data?.genres??[];
                return Expanded(child:
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context,index)
                    {
                      return BrowsItem();
                    })
                );
              },
        )
      ],
    );
  }

  BrowsModel? brows_model=null;

  void onBrowsSelected(category)
  {
    brows_model=category;
    setState(() {

    });
  }
}
