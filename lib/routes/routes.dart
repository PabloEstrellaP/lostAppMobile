import 'package:flutter/material.dart';

import 'package:flutterapp2/pages/loadingPage.dart';
import 'package:flutterapp2/pages/loginPage.dart';
import 'package:flutterapp2/pages/menuPage.dart';
import 'package:flutterapp2/pages/petDetails.dart';
import 'package:flutterapp2/pages/registerPage.dart';
import 'package:flutterapp2/pages/example.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'login'    : ( _ ) => LoginPage(),
  '/'        : ( _ ) => MenuPage(),
  'loading'  : ( _ ) => LoadingPage(),
  'register' : ( _ ) => RegisterPage(),
  'details'  : ( _ ) => PetDetailsPage(),
  'example'  : ( _ ) => LostPetRegister()

};


