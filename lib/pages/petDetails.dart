import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutterapp2/helpers/dialog.dart';
import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/models/reports.dart';
import 'package:flutterapp2/models/user.dart';
import 'package:flutterapp2/services/googleSignInService.dart';
import 'package:flutterapp2/services/reportsService.dart';
// import 'package:flutterapp2/services/petsService.dart';
import 'package:flutterapp2/widgets/ActionButton.dart';
import 'package:flutterapp2/widgets/CardData.dart';
import 'package:flutterapp2/widgets/CustomAlertDialog.dart';
import 'package:flutterapp2/widgets/CustomMaterialBotton.dart';
import 'package:flutterapp2/widgets/ImageCard.dart';
import 'package:flutterapp2/widgets/Subtitle.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';
import 'package:flutterapp2/widgets/customInput.dart';
import 'package:photo_view/photo_view.dart';

class PetDetailsPage extends StatefulWidget {

  final Pet? littlePet;
  final bool isPreview;

  PetDetailsPage({Key? key, 
    this.littlePet,
    this.isPreview = false,
  }) : super(key: key);

  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  
  Pet? petData;
  Report? newReport;
  User? user;

  final _textController = new TextEditingController();
  
  @override
  void initState (){
    _getAllUserDataRegister();
    petData = widget.littlePet;
    super .initState ();
    // _getPetDetails('6188c12978fbc33778a11a32');

  }

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.44,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CurvedPainter(),
                    child: Container(
                      margin: const EdgeInsets.only( top: 10 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage( petData!.profileImg ),
                            maxRadius: size.height * 0.12,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CardData(
                                title: '${petData!.name}',
                                SubTitle: 'Nombre',
                              ),
                              CardData(
                                title: '${petData!.gender}',
                                SubTitle: 'Genero',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CardData(
                                title: '${petData!.breed}',
                                SubTitle: 'Raza',
                              ),
                              CardData(
                                title: '${petData!.age == 1 ? petData!.age + ' año' : petData!.age + ' años'}',
                                SubTitle: 'Edad',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                Subtitle(
                  title: 'Descripción', 
                  size: size
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only( left: 10, right: 10),
                  child: Text("${petData!.description}",
                    style: TextStyle( fontSize: size.width * 0.04),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Subtitle(
                  title: 'Fotos', 
                  size: size
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: size.height * 0.17,
                  width: size.width * 0.9,
                  child: ListView(
                    scrollDirection: Axis.horizontal, 
                    children: _getListings( size, context ),
                  ),
                ),
                ActionButton(
                  text: 'Reportar', 
                  icon: Icons.report,
                  color: Colors.green,
                  operation:(){
                    if( widget.isPreview  ){
                      print('Hola');
                    }else{
                      _showTextDialog( context );
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  _showDialog(BuildContext ctx, String img) {
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

  _showTextDialog( BuildContext ctx ) {
    showDialog(context: ctx,
        builder: (context) {
          return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomInput(
                  icon: Icons.report, 
                  placeholder: 'Descripción de la mascota perdida', 
                  textController: _textController,
                  hasMorelLines: true,
                  hasMoreOpacity: true,
                )
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomMaterialButton(
                      size: MediaQuery.of(context).size, 
                      text: 'Cancelar', 
                      color: Colors.red, 
                      function: (){
                        Navigator.pop(context, 'Cancelar');
                      }
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomMaterialButton(
                      size: MediaQuery.of(context).size, 
                      text: 'Aceptar', 
                      color: Colors.green, 
                      function: () async{
                        Navigator.pop(context, 'aceptar');
                        await _addReportDialog( context, MediaQuery.of(context).size );
                      }
                    ),
                  ],
                )
              ],
          );
        }
    );
  }
  
  Future<void> _addReportDialog( BuildContext context, Size size ) async {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return CustomAlertDialog(
          title: '¿Seguro de mandar el reporte de la mascota?',
          text: 'Cancelar',
          text2: 'Aceptar',
          color: Colors.red,
          color2: Colors.green,
          function: (){
            Navigator.pop(context);
          },
          function2: () async{
            CustomDialog.showDialog(context, size);
            _generateReport();
            await ReportsService.addReports(newReport!);
            CustomDialog.closeDialog(context);
            Navigator.pop(context);
            _textController.text = '';
            _goToHome( context, size, '¡Se ha enviado con éxito!' );
          },
        );
      },
    );
  }

  void _generateReport(){
    newReport = new Report(
      id: 'Example', 
      description: _textController.text, 
      pet: petData!, 
      date: new DateTime.now(), 
      from: user!,
      to: petData!.user,
      isCheked: false
    );
  }

  Future<User?> _getAllUserDataRegister() async {
    user = await GoogleSignInService.getAllUserData(); 
    return user;
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
          },
          function2: () async{
            Navigator.pop(context);
          },
        );
      },
    );
  }

  List<ImageCard> _getListings( Size size, BuildContext context ) { 
    
    List<ImageCard> info = [];
    for( int i = 0; i < petData!.objIMG.length; i++){
      info.add(
        new ImageCard(
          onPressed: (){
            _showDialog( context,
              'https://firebasestorage.googleapis.com/v0/b/lostpet-ccadb.appspot.com/o${petData!.objIMG[i].name}?alt=media&token=${petData!.objIMG[i].token}'              
              // 'https://estaticos.muyinteresante.es/media/cache/1140x_thumb/uploads/images/gallery/59bbb29c5bafe878503c9872/husky-siberiano-bosque.jpg'
            );
          }, 
          size: size, 
          imgPath: 'https://firebasestorage.googleapis.com/v0/b/lostpet-ccadb.appspot.com/o${petData!.objIMG[i].name}?alt=media&token=${petData!.objIMG[i].token}',
        )
      );
    }
    return info;
  }
}