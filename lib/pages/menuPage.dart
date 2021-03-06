import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutterapp2/pages/lostPetRegister.dart';
import 'package:flutterapp2/widgets/PetsGrid.dart';
import 'package:flutterapp2/widgets/SideMenu.dart';
import 'package:flutterapp2/widgets/customFloatingActionButton.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/services/petsService.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';
import 'package:flutterapp2/widgets/customInput.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key,}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Pet> data = [];
  final searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavDrawer(),
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  // height: size.height * 0.25,
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
                            child: Text('Menú', style: GoogleFonts.pacifico(
                                textStyle: TextStyle(
                                  color: Colors.white, 
                                  fontSize: size.height * 0.04,
                                ),
                              ),
                            ),
                          ),
                          // CustomInput(
                          //   icon: Icons.search_rounded, 
                          //   placeholder: 'Buscar', 
                          //   textController: searchCtrl
                          // )
                        ],
                      ),
                    ),
                  )
                ),

                PetsGrid(
                  size: size, 
                  function: _getPets(), 
                  data: data, 
                  context: context
                )
                
              ]
            ),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }

  Future<Object> _getPets() async {
    data = [];
    final response = await PetService.getPets();
    for( var dataJson in response['msg']){
      data.add(new Pet.fromJson(dataJson));
    }
    // setState(() {
      
    // });
    return data;
  }
  
}
 