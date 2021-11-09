import 'package:flutter/material.dart';
import 'package:flutterapp2/helpers/dialog.dart';
import 'package:loading_animations/loading_animations.dart';
class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          LoadingBouncingGrid.circle(
                  size: 90,
                  backgroundColor: Colors.black,
                ),
          LoadingBouncingGrid.square(
                  size: 90,
                  backgroundColor: Colors.black,
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          CustomDialog.showDialog(context, size );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}