import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutterapp2/models/pet.dart';
// import 'package:flutterapp2/services/petsService.dart';
import 'package:flutterapp2/widgets/ActionButton.dart';
import 'package:flutterapp2/widgets/CardData.dart';
import 'package:flutterapp2/widgets/ImageCard.dart';
import 'package:flutterapp2/widgets/Subtitle.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';
import 'package:photo_view/photo_view.dart';

class PetDetailsPage extends StatefulWidget {

  final Pet? littlePet;

  PetDetailsPage({Key? key, 
    this.littlePet
  }) : super(key: key);

  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  
  Pet? petData;


  @override
  void initState (){
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
                  operation: (){},
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