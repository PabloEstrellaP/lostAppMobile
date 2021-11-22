import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutterapp2/helpers/dialog.dart';
import 'package:flutterapp2/models/user.dart';
import 'package:flutterapp2/pages/petDetails.dart';
import 'package:flutterapp2/pages/userProfile.dart';
import 'package:flutterapp2/services/googleSignInService.dart';
import 'package:flutterapp2/widgets/CustomAlertDialog.dart';
import 'package:flutterapp2/widgets/ImageCard.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path/path.dart';

import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/services/firebaseService.dart';
import 'package:flutterapp2/services/petsService.dart';
import 'package:flutterapp2/widgets/ActionButton.dart';
import 'package:flutterapp2/widgets/customDropdown.dart';
import 'package:flutterapp2/widgets/customInput.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

class LostPetEdit extends StatefulWidget {
  
  final Pet? littelPet;

  LostPetEdit({
    Key? key,
    this.littelPet
  }) : super(key: key);

  @override
  LostPetEditState createState() => LostPetEditState();
}

class LostPetEditState extends State<LostPetEdit> {
  
  final nameCtrl = TextEditingController();
  final breedCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  
  String imgProf = ''; 
  String gender = 'Masculino';
  List<String> genderes = ['Masculino', 'Femenino'];

  String isLost = 'Perdido';
  List<String> lostlist = ['Perdido', 'Encontrado'];

  String age = '1';
  List<String> ages = [];
  List<ObjectImage> listObjIMG = [];
  
  UploadTask? task;
  List<File>? file = [];
  File? fileProfile;

  double amount = 0;

  Pet? newPet;
  User? newUser;

  int porcent = 0;
  int sumPorc = 0;

  @override
  void initState (){

    nameCtrl.text = widget.littelPet!.name;
    breedCtrl.text = widget.littelPet!.breed;
    descriptionCtrl.text = widget.littelPet!.description;
    gender = widget.littelPet!.gender;
    age = widget.littelPet!.age;
    listObjIMG = widget.littelPet!.objIMG; 

    getImageFileFromAssets('perro.png');
    _getAllUserDataRegister();
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
                          BorderedText(
                            strokeWidth: 2,
                            strokeColor: Colors.black,
                            child: Text('Pet Edit', style: GoogleFonts.pacifico(
                                textStyle: TextStyle(
                                  color: Colors.white, 
                                  fontSize: size.height * 0.04,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              // SizedBox(
                              //   height: size.height * 0.15,
                              //   width: size.width * 0.3,
                              //   child: Stack(
                              //     clipBehavior: Clip.none,
                              //     fit: StackFit.expand,
                              //     children: [
                              //       CircleAvatar(
                              //       backgroundImage:
                              //         // imgPro
                              //         new FileImage(fileProfile!)
                              //       ),
                              //       Positioned(
                              //         bottom: 0,
                              //         right: -25,
                              //         child: RawMaterialButton(
                              //           onPressed: () {
                              //             _selectProfileFile();
                              //           },
                              //           elevation: 2.0,
                              //           fillColor: Color(0xFFF5F6F9),
                              //           child: Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                              //           padding: EdgeInsets.all(15.0),
                              //           shape: CircleBorder(),
                              //         )
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              CircleAvatar(
                                minRadius: size.width * 0.15,
                                backgroundImage: NetworkImage(widget.littelPet!.profileImg)
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
                // Container(
                //   margin: const EdgeInsets.only(left: 20, right: 20),
                //   child: CustomDropdown(
                //     value: isLost,
                //     items: isLostList, 
                //     function: (String? newValue) {
                //       setState(() {
                //         isLost = newValue!;
                //       });
                //     },
                //     hasPrefix: true,
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.only( left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropdown(
                        value: isLost,
                        items: lostlist,
                        function: (String? newValue) {
                        setState(() {
                          isLost = newValue!;
                        });
                      },),
                      Container(
                        width: size.width * 0.4,
                        child: CustomInput(
                          icon: Icons.add_reaction, 
                          placeholder: 'Raza', 
                          textController: breedCtrl,
                          hasMoreOpacity: true
                        ),
                      )
                    ],
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
                // ActionButton(
                //   text: 'Add images', 
                //   icon: Icons.add_photo_alternate, 
                //   color: Colors.blueAccent,
                //   operation: _selectFile,
                // ),
                // Container(
                //   margin: const EdgeInsets.only( top: 15, left: 20, right: 20 ),
                //   height: MediaQuery.of(context).size.height * amount,
                //   width: MediaQuery.of(context).size.width,
                //   child: GridView.builder(
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisSpacing: 0,
                //       mainAxisSpacing: 0,
                //       crossAxisCount: 3,
                //     ),
                //     itemCount: file!.length,
                //     itemBuilder: (context, index) {
                //       return new GestureDetector(
                //         onTap: () {
                //           _showDialog( context, file![index]);
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //               fit: BoxFit.cover,
                //               image: new FileImage(file![index]),
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Container(
                  height: size.height * 0.17,
                  width: size.width * 0.9,
                  child: ListView(
                    scrollDirection: Axis.horizontal, 
                    children: _getListings( size, context ),
                  ),
                ),
                ActionButton(
                  text: 'Editar', 
                  icon: Icons.edit, 
                  color: Colors.green,
                  operation: () async{
                    await _editPetDialog( context, size );
                  },
                ),
                ActionButton(
                  text: 'Eliminar', 
                  icon: Icons.delete, 
                  color: Colors.red,
                  operation: () async{
                    await _deletePetDialog( context, size );
                  },
                ),
                ActionButton(
                  text: 'Previsualizar', 
                  icon: Icons.preview, 
                  color: Colors.blueAccent,
                  operation: () async{
                    _previewPet();
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<void> _deletePetDialog( BuildContext context, Size size ) async {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return CustomAlertDialog(
          title: '¿Seguro de eliminar esta mascota?',
          text: 'Cancelar',
          text2: 'Aceptar',
          color: Colors.red,
          color2: Colors.green,
          function: (){
            Navigator.pop(context);
          },
          function2: () async{
            CustomDialog.showDialog(context, size);
            _generatePet();
            // await PetService.deletePet( newPet! );
            CustomDialog.closeDialog(context);
            Navigator.pop(context);
            _goToHome( context, size, '¡Se ha eliminado con éxito!' );
          },
        );
      },
    );
  }

  Future<void> _editPetDialog( BuildContext context, Size size ) async {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return CustomAlertDialog(
          title: '¿Seguro de editar esta mascota?',
          text: 'Cancelar',
          text2: 'Aceptar',
          color: Colors.red,
          color2: Colors.green,
          function: (){
            Navigator.pop(context);
          },
          function2: () async{
            CustomDialog.showDialog(context, size);
            _generatePet();
            await PetService.putPet( newPet! );
            CustomDialog.closeDialog(context);
            Navigator.pop(context);
            _goToHome( context, size, '¡Se ha editado con éxito!' );
          },
        );
      },
    );
  }

  Future<void> _goToHome( BuildContext context, Size size, String title) async {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return CustomAlertDialog(
          isOnlyAllow: true,
          title: title,
          text: 'Aceptar',
          text2: '------',
          color: Colors.green,
          color2: Colors.red,
          function: (){
            Navigator.pop(context);
            Navigator.pushReplacement(context, 
              PageRouteBuilder(
                pageBuilder: ( _, __, ___ ) => UserProfile(),
                transitionDuration: Duration(milliseconds: 2)
            ));
          },
          function2: () async{
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _generateAge(){
    for( int i = 1; i <= 50; i++ ){
      ages.add( i.toString() );
    }
  }

  Future uploadFile( eachFile, int i, bool isProfile ) async {
    if (eachFile == null) return;

    DateTime date = new DateTime.now();
    
    final destination = '/${newUser!.id}-${date.month}${date.day}${date.year}${date.second}${date.hour}${date.millisecond}';

    task = FirebaseService.uploadFile(destination, eachFile);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print(newPet);
    if( isProfile ){
      setState(() {
        imgProf = urlDownload;
      });
    }else{
      listObjIMG.add( new ObjectImage(name: destination, token: urlDownload.substring( urlDownload.length - 36 )));
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    File IMG = File('${(await getTemporaryDirectory()).path}/$path');
    setState((){
      fileProfile = IMG;
    });
    return IMG;
  }

  Future<User?> _getAllUserDataRegister() async {
    newUser = await GoogleSignInService.getAllUserData(); 
    return newUser;
  }


  void _previewPet() async {
    _generatePet();
    Navigator.push(context, 
      PageRouteBuilder(
        pageBuilder: ( _, __, ___ ) => PetDetailsPage( littlePet: newPet,),
        transitionDuration: Duration(milliseconds: 2)
    ));
  }

  void _generatePet(){
    newPet = new Pet(
      name: nameCtrl.text, 
      gender: gender, 
      age: age,
      isLost: true,
      breed: breedCtrl.text, 
      description: descriptionCtrl.text, 
      profileImg: widget.littelPet!.profileImg, 
      objIMG: listObjIMG, 
      date: new DateTime(2000),
      user: newUser!,
      id: widget.littelPet!.id
    );
  }

  List<ImageCard> _getListings( Size size, BuildContext context ) { 
    
    List<ImageCard> info = [];
    for( int i = 0; i < listObjIMG.length; i++){
      info.add(
        new ImageCard(
          onPressed: (){
            _showDialogIMG( context,
              'https://firebasestorage.googleapis.com/v0/b/lostpet-ccadb.appspot.com/o${listObjIMG[i].name}?alt=media&token=${listObjIMG[i].token}'              
              // 'https://estaticos.muyinteresante.es/media/cache/1140x_thumb/uploads/images/gallery/59bbb29c5bafe878503c9872/husky-siberiano-bosque.jpg'
            );
          }, 
          size: size, 
          imgPath: 'https://firebasestorage.googleapis.com/v0/b/lostpet-ccadb.appspot.com/o${listObjIMG[i].name}?alt=media&token=${listObjIMG[i].token}',
        )
      );
    }
    return info;
  }

  _showDialogIMG(BuildContext ctx, String img) {
    showDialog(context: ctx,
        builder: (context) {
          return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: PhotoView(
                    imageProvider: NetworkImage(img,
                    
                    // scale: 60.5
                  ),
                )
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
