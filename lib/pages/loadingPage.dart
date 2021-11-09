import 'package:flutter/material.dart';
import 'package:flutterapp2/pages/menuPage.dart';

import 'package:flutterapp2/services/googleSignInService.dart';

import 'package:flutterapp2/pages/loginPage.dart';
import 'package:flutterapp2/widgets/CircularProgressInd.dart';
import 'package:flutterapp2/widgets/logoIcon.dart';
class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot ){
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(10),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogoIcon(
                        title: 'LostPet'
                      ),
                      CircularProgressInd(),
                      Text('Estamos validando sus datos...', style: TextStyle( 
                        fontSize: MediaQuery.of(context).size.width * 0.05, 
                        fontWeight: FontWeight.w300 
                        ),
                      )

                    ],
                  ),
                )),
            ),
          );
        }),
    );
  }
  
  Future checkLoginState( BuildContext context ) async {
    Future.delayed(Duration(milliseconds: 4000), () async {
      final response = await GoogleSignInService.renewToken();

      if( response['ok'] ){
        GoogleSignInService.saveToken(response['token'], response['msg']);
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            pageBuilder: ( _, __, ___ ) => MenuPage(),
            transitionDuration: Duration(milliseconds: 0)
          )
        );
      }else{
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            pageBuilder: ( _, __, ___ ) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0)
          )
        );
      }  // Do something
    });

    
  }
}