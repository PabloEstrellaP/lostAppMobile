import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  
  final Size size;
  final String title;
  
  const Subtitle({Key? key,
    required this.title,
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text( this.title, 
      style: TextStyle( 
        color: Colors.blue.shade800, 
          fontSize: this.size.width * 0.05
      ),
    );
  }
}