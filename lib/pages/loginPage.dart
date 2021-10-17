import 'package:flutter/material.dart';
import 'package:flutterapp2/widgets/GoogleButtonSignIn.dart';
import 'package:flutterapp2/widgets/labels.dart';
import 'package:flutterapp2/widgets/logoIcon.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    LogoIcon(title: 'LostPet'),
                    GoogleButtonSignIn(
                      title: ' Inicia sesión con google',
                      isLogin: true,
                    ),
                    Labels(
                      path: 'register', 
                      title: '¿No tienes una cuenta?', 
                      subTitle: '¡Registra una!'
                    ),
                    Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),)

                  ],
                ),
              ),
            ))
        ),
    );
  }
}