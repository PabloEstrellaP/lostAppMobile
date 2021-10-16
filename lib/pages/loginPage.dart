import 'package:flutter/material.dart';
import 'package:flutterapp2/widgets/GoogleButtonSignIn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('This is login'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleButtonSignIn()
              ],
            ),
          ),
        ),
    );
  }
}