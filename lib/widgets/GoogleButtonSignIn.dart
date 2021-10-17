import 'package:flutter/material.dart';
import 'package:flutterapp2/pages/menuPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterapp2/services/googleSignInService.dart';

class GoogleButtonSignIn extends StatelessWidget {
  final String title;
  final bool isLogin;
  const GoogleButtonSignIn({
    Key? key,
    required this.title,
    required this.isLogin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left: 30, right: 30),
      child: MaterialButton(
        splashColor: Colors.transparent,
        minWidth: double.infinity,
        height: 40,
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        onPressed: () async{
          final response = await GoogleSignInService.signInWithGoogle( this.isLogin );
          if( response['ok'] ){
            await GoogleSignInService.saveToken(response['token']);
            Navigator.pushReplacement(
              context, 
              PageRouteBuilder(
                pageBuilder: ( _, __, ___ ) => MenuPage(),
                transitionDuration: Duration(milliseconds: 0)
              )
            );
          }else{
            await GoogleSignInService.signOut();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon( FontAwesomeIcons.google, color: Colors.white,),
            Text( this.title, style: TextStyle( color: Colors.white, fontSize: 17 ),)
          ],
        ),
      ),
    );
  }
}