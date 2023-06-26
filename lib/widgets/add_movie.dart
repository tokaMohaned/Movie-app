import 'package:flutter/material.dart';

class AddMovie extends StatelessWidget {
  const AddMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.bookmark,color: Color.fromRGBO(81, 78, 75, 70),size: 50,),
        Icon(Icons.add,color: Colors.white,size: 20,),
      ],
    );
  }
}
