import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/widgets/widgets.dart';
import '../provider/my_app_provider.dart';

class MovieAdded extends StatelessWidget {
  var result;
   MovieAdded({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyAppProvider>(context);
    return GestureDetector(
      onTap: (){
        provider.removeWatchList(result);
        showSnackBar(color: Colors.redAccent, context: context, text: 'Movie has been removed to watchList',);
      },
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.bookmark,color:  Color.fromRGBO(215, 158, 51, 70),size: 50,),
          Icon(Icons.check,color: Colors.white,size: 20),
        ],
      ),
    );
  }
}
