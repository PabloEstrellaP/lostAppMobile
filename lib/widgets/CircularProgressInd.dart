import 'dart:async';

import 'package:flutter/material.dart';

class CircularProgressInd extends StatelessWidget {
  const CircularProgressInd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( top: 50, bottom: 50),
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        value: null,  
        strokeWidth: 5,
      ),
    );
  }
}