import 'package:flutter/material.dart';

import 'package:flutterapp2/pages/loginPage.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is loading page'),
      ),
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot ){
          return Center(
            child: Text('Espere...'),
          );
        }),
    );
  }
  
  Future checkLoginState( BuildContext context ) async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    });
  }
}