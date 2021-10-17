import 'package:flutter/material.dart';

import 'package:flutterapp2/widgets/GoogleButtonSignIn.dart';
import 'package:flutterapp2/widgets/labels.dart';
import 'package:flutterapp2/widgets/logoIcon.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogoIcon( title: 'LostPet',),
                  GoogleButtonSignIn(
                    title: ' Registrate con google',
                    isLogin: false,
                  ),
                  Labels(
                    path: 'login',
                    title: '¿Ya tienes una cuenta?',
                    subTitle: '¡Ingresa ahora!',
                  ),
                ],
              ),
            ),
          )),
      ),
    );
  }
}