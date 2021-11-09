import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/widgets/CircularProgressInd.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';

abstract class CustomDialog {
  static showDialog( BuildContext context, Size size ){
    showCupertinoDialog(
      context: context, 
      builder: ( _ ){
        return WillPopScope(
          child: Container(
            width: 45,
            height: 35,
            color: Colors.white.withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingBouncingGrid.square(
                    borderColor: Colors.black,
                    borderSize: 1,
                    size: 90,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BorderedText(
                    strokeWidth: 1.4,
                    strokeColor: Colors.black,
                    child: Text('Cargando...', style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                          color: Colors.white, 
                          fontSize: size.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // child: CircularProgressIndicator(),
            ),
          ), 
          onWillPop: () async => false
        );
      });
  }

  static showVerifyData( BuildContext context, Size size ){
    showCupertinoDialog(
      context: context, 
      builder: ( _ ){
        return WillPopScope(
          child: Container(
            width: 45,
            height: 35,
            color: Colors.white.withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressInd(),
                  SizedBox(
                    height: 10,
                  ),
                  BorderedText(
                    strokeWidth: 2,
                    strokeColor: Colors.black,
                    child: Text('Estamos validando sus datos...', style: GoogleFonts.mcLaren(
                        textStyle: TextStyle(
                          color: Colors.white, 
                          fontSize: size.height * 0.03,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // child: CircularProgressIndicator(),
            ),
          ), 
          onWillPop: () async => false
        );
      });
  }

  static closeDialog( BuildContext context ){
    Navigator.pop(context);
  } 
}