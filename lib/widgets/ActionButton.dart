import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback operation;

  const ActionButton({Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( top: 10, left: 20, right: 20),
      child: MaterialButton(
        onPressed: this.operation,
        splashColor: Colors.transparent,
        // minWidth: size.width * 0.05,
        height: 40,
        color: this.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon( this.icon, color: Colors.white,),
            Text( ' ${this.text}', style: TextStyle( color: Colors.white, fontSize: 17 ),)
          ],
        ),
      ),
    );
  }
}