import 'package:flutter/material.dart';
import 'package:flutterapp2/routes/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


// void main() => runApp(MyApp());

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LostPet',
      initialRoute: 'notifications',
      routes: appRoutes,
    );
  }
}

