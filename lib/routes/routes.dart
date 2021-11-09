import 'package:flutter/material.dart';

import 'package:flutterapp2/pages/loadingPage.dart';
import 'package:flutterapp2/pages/loginPage.dart';
import 'package:flutterapp2/pages/lostPetRegister.dart';
import 'package:flutterapp2/pages/menuPage.dart';
import 'package:flutterapp2/pages/petDetails.dart';
import 'package:flutterapp2/pages/registerPage.dart';
import 'package:flutterapp2/pages/example.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  '/'        : ( _ ) => MenuPage(),
  'login'    : ( _ ) => LoginPage(),
  'loading'  : ( _ ) => LoadingPage(),
  'register' : ( _ ) => RegisterPage(),
  'details'  : ( _ ) => PetDetailsPage(),
  'petRegi'  : ( _ ) => LostPetRegister(),
  'example'  : ( _ ) => Example()

};


