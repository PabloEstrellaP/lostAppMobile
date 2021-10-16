import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  
  final String title;

  const LogoIcon({Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only( top: 50),
        child: Column(
          children: [
            Image(image: AssetImage('assets/perro.png')),
            SizedBox( height: 20 ),
            Text( this.title, style: TextStyle( fontSize: 30 ),)
          ],
        ),
      ),
    );
  }
}