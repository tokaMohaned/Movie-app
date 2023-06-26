import 'package:flutter/material.dart';

class MovieAdded extends StatelessWidget {
  const MovieAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Holaaaa");
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
