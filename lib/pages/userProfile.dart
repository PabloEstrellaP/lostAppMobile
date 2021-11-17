import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutterapp2/helpers/dialog.dart';
import 'package:flutterapp2/models/user.dart';
import 'package:flutterapp2/services/googleSignInService.dart';
import 'package:flutterapp2/widgets/PetsGrid.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/services/petsService.dart';

import 'package:flutterapp2/widgets/SideMenu.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  List<Pet> data = [];
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    _getAllUserDataRegister();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavDrawer(),
      body: FutureBuilder(
        future: _getAllUserDataRegister(),
        builder: ( context, AsyncSnapshot snapshot){
          if( !snapshot.hasData ){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else{
            return SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.25,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: CurvedPainter(),
                          child: Container(
                            margin: const EdgeInsets.only( top: 2, left: 20, right: 20 ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BorderedText(
                                  strokeWidth: 2,
                                  strokeColor: Colors.black,
                                  child: Text('User Profile', style: GoogleFonts.pacifico(
                                      textStyle: TextStyle(
                                        color: Colors.white, 
                                        fontSize: size.height * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( left: 5 ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        minRadius: size.width * 0.15,
                                        backgroundImage: NetworkImage( user!.picturePath )
                                      ),
                                      SizedBox(
                                        width: size.width * 0.05,
                                      ),
                                      BorderedText(
                                        strokeWidth: 2,
                                        strokeColor: Colors.black,
                                        child: Text('${user!.name}', style: GoogleFonts.mcLaren(
                                            textStyle: TextStyle(
                                              color: Colors.white, 
                                              fontSize: size.height * 0.03,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                      PetsGrid(
                        isEdit: true,
                        size: size, 
                        function: _getPetsByUser(), 
                        data: data, 
                        context: context
                      )
                    ],
                  ),
                ),
              )
            );
          }
        }
      )
    );
  }

  Future<Object> _getPetsByUser() async {
    data = [];
    final response = await PetService.getPetByUser(user!.id, true);
    for( var dataJson in response['msg']){
      data.add(new Pet.fromJson(dataJson));
    }
    return data;
  }

  Future<User?> _getAllUserDataRegister() async {
    user = await GoogleSignInService.getAllUserData(); 
    return user;
  }

}