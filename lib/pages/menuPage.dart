import 'package:flutter/material.dart';

import 'package:flutterapp2/services/googleSignInService.dart';
import 'package:flutterapp2/widgets/GoogleButtonSignOut.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ontext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is menu page'),
        actions: [
          GoogleButtonSignOut()
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                final data = await GoogleSignInService.getToken();
                print(data);
              },
              child: Center(
                child: Text('Tap me'),
              ),
            )
          ],
        )),
    );
  }
}