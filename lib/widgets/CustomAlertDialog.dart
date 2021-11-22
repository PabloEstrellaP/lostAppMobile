import 'package:flutter/material.dart';
import 'package:flutterapp2/widgets/CustomMaterialBotton.dart';
class CustomAlertDialog extends StatelessWidget {

  final String title;
  final String text;
  final String text2;
  final Color color;
  final Color color2;

  final VoidCallback function;
  final VoidCallback function2;

  final bool isOnlyAllow;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.text,
    required this.text2,
    required this.color,
    required this.color2,
    required this.function,
    required this.function2,
    this.isOnlyAllow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Image.asset('assets/perro.png', height: 100),
              SizedBox(height: 16.0),
              Text(
                this.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _getListings( context )
              )
            ],
          ),
        ),
      ),
    );
  }

  
  List<Widget> _getListings( BuildContext context ) { 
    
    List<Widget> addBtn = [];
    if( !this.isOnlyAllow ){
      addBtn.add(
        CustomMaterialButton( 
          size: MediaQuery.of(context).size,
          text: this.text,
          color: this.color,
          function: this.function,
        ),
      );
      addBtn.add(
         SizedBox(
          width: 5,
        ),
      );
      addBtn.add(
        CustomMaterialButton( 
          size: MediaQuery.of(context).size,
          text: this.text2,
          color: this.color2,
          function: this.function2,
        )
      );
    }else{
      addBtn.add(
        CustomMaterialButton( 
          size: MediaQuery.of(context).size,
          text: this.text,
          color: this.color,
          function: this.function,
        ),
      );
    }
    return addBtn;
  }
}