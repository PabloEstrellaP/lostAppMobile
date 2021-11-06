import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import 'package:flutterapp2/widgets/ActionButton.dart';
import 'package:flutterapp2/widgets/customDropdown.dart';
import 'package:flutterapp2/widgets/customInput.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';

class LostPetRegister extends StatefulWidget {
  LostPetRegister({Key? key}) : super(key: key);

  @override
  LostPetRegisterState createState() => LostPetRegisterState();
}

class LostPetRegisterState extends State<LostPetRegister> {
  
  final nameCtrl = TextEditingController();
  final breedCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  
  String gender = 'Masculino';
  List<String> genderes = ['Masculino', 'Femenino'];

  String age = '1';
  List<String> ages = [];
  
  List<File>? file = [];
  double amount = 0;


  @override
  void initState (){
    super .initState ();
    _generateAge();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold( 
      // backgroundColor: Colors.brown[50], 
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CurvedPainter(),
                    child: Container(
                      margin: const EdgeInsets.only( top: 2, left: 20, right: 20 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text('Pet Register', style: GoogleFonts.pacifico(
                              textStyle: TextStyle(
                                color: Colors.white, 
                                fontSize: size.height * 0.04,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: size.height * 0.15,
                                width: size.width * 0.3,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage('https://www.attendit.net/images/easyblog_shared/July_2018/7-4-18/totw_network_profile_400.jpg'),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: -25,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          print('Hola mundo');
                                        },
                                        elevation: 2.0,
                                        fillColor: Color(0xFFF5F6F9),
                                        child: Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                                        padding: EdgeInsets.all(15.0),
                                        shape: CircleBorder(),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only( left: 10 ),
                                width: size.width * 0.57,
                                  child: CustomInput(
                                  icon: Icons.text_fields, 
                                  placeholder: 'Nombre', 
                                  textController: nameCtrl
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only( left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropdown(
                        value: gender,
                        items: genderes,
                        function: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },),
                      CustomDropdown(
                        value: age,
                        items: ages, 
                        function: (String? newValue) {
                          setState(() {
                            age = newValue!;
                          });
                        },
                        hasPrefix: true,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: CustomInput(
                    icon: Icons.add_reaction, 
                    placeholder: 'Raza', 
                    textController: breedCtrl,
                    hasMoreOpacity: true
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only( left: 20, right: 20),
                  child: CustomInput(
                    icon: Icons.description, 
                    placeholder: 'Descripción', 
                    textController: descriptionCtrl,
                    hasMoreOpacity: true,
                    hasMorelLines: true,
                  ),
                ),
                ActionButton(
                  text: 'Add images', 
                  icon: Icons.add_photo_alternate, 
                  color: Colors.blueAccent,
                  operation: _selectFile,
                ),
                Container(
                  margin: const EdgeInsets.only( top: 15, left: 20, right: 20 ),
                  height: MediaQuery.of(context).size.height * amount,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 3,
                    ),
                    itemCount: file!.length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                        onTap: () {
                          _showDialog( context, file![index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: new FileImage(file![index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ActionButton(
                  text: 'Registrar', 
                  icon: Icons.add, 
                  color: Colors.green,
                  operation: (){},
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  void _generateAge(){
    for( int i = 1; i <= 50; i++ ){
      ages.add( i.toString() );
    }
  }

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result == null) return;
    List<File> files = result.paths.map((path) => File(path!)).toList();
    setState((){
      file = files;
      amount = 0.14 * (files.length / 3).ceil();
    });
  }

  _showDialog(BuildContext ctx, File img) {
    showDialog(context: ctx,
        builder: (context) {
          return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: new FileImage(img),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
          );
        }
    );
  }
}