import 'package:flutter/material.dart';
import 'package:flutterapp2/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LostPet',
      initialRoute: 'register',
      routes: appRoutes,
    );
  }
}

