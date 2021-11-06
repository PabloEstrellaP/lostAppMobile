import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyBoardType;
  final bool isPassword;
  final bool hasMoreOpacity;
  final bool hasMorelLines;

  const CustomInput({Key? key,
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyBoardType = TextInputType.text,
    this.isPassword = false,
    this.hasMoreOpacity = false,
    this.hasMorelLines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 5, left: 5, bottom: 5, right: 20 ),
      margin: EdgeInsets.only( bottom: 20, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity( this.hasMoreOpacity ? 0.3 : 0.05 ),
            offset: Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        autofocus: false,
        maxLines: this.hasMorelLines ? 5 : 1,
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyBoardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon( this.icon ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder
        ),
      ),
    );
  }
}