import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final Size size;
  final String text;
  final Color color;

  final VoidCallback function;

  const CustomMaterialButton({
    Key? key,
    required this.size,
    required this.text,
    required this.color,
    required this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      height: 40,
      color: this.color,
      minWidth: size.width * 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      onPressed: this.function,
      child: Center(
        child: Text( this.text, style: TextStyle( color: Colors.white, fontSize: 17 )),
      ),
    );
  }
}