import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  
  final VoidCallback onPressed;
  final Size size;
  final String imgPath;
  
  const ImageCard({Key? key,
    required this.onPressed,
    required this.size,
    required this.imgPath 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( left: 2.5, right: 2.5),
      height: this.size.height * 0.10,
      width: this.size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.black
      ),
      // color: Colors.black,
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Image.network(this.imgPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}