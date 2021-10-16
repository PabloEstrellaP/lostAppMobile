import 'package:flutter/material.dart';
import 'package:flutterapp2/pages/loginPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterapp2/services/googleSignInService.dart';


class GoogleButtonSignOut extends StatelessWidget {
  const GoogleButtonSignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async{
        await GoogleSignInService.signOut();
        Navigator.pushReplacement(
          context, 
          PageRouteBuilder(
            pageBuilder: ( _, __, ___ ) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0)
          )
        );
      }, 
      icon: Icon(FontAwesomeIcons.doorOpen));
  }
}
