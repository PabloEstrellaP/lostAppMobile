import 'package:flutter/material.dart';

import 'package:flutterapp2/widgets/GoogleButtonSignIn.dart';
import 'package:flutterapp2/widgets/labels.dart';
import 'package:flutterapp2/widgets/logoIcon.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoIcon( title: 'LostApp',),
                GoogleButtonSignIn(),
                Labels(
                  path: 'login',
                  title: '¿Ya tienes una cuenta?',
                  subTitle: '¡Ingresa ahora!',
                ),
                Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),)
              ],
            ),
          ),
        )),
    );
  }
}