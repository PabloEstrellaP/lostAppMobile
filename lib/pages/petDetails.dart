import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp2/widgets/CardData.dart';
import 'package:flutterapp2/widgets/ImageCard.dart';
import 'package:flutterapp2/widgets/Subtitle.dart';
import 'package:photo_view/photo_view.dart';

class PetDetailsPage extends StatefulWidget {
  PetDetailsPage({Key? key}) : super(key: key);

  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
                            backgroundImage: NetworkImage('https://www.hola.com/imagenes/estar-bien/20190820147813/razas-perros-pequenos-parecen-grandes/0-711-550/razas-perro-pequenos-grandes-m.jpg'),
                            maxRadius: size.height * 0.12,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CardData(
                                title: 'Pato',
                                SubTitle: 'Nombre',
                              ),
                              CardData(
                                title: 'Macho',
                                SubTitle: 'Genero',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CardData(
                                title: 'Husky',
                                SubTitle: 'Raza',
                              ),
                              CardData(
                                title: '1 año',
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
                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
                    children: [
                      ImageCard(
                        onPressed: (){
                          _showDialog( context,
                            'https://estaticos.muyinteresante.es/media/cache/1140x_thumb/uploads/images/gallery/59bbb29c5bafe878503c9872/husky-siberiano-bosque.jpg'
                          );
                        }, 
                        size: size, 
                        imgPath: 'https://estaticos.muyinteresante.es/media/cache/1140x_thumb/uploads/images/gallery/59bbb29c5bafe878503c9872/husky-siberiano-bosque.jpg',
                      ),
                      ImageCard(
                        onPressed: (){
                          _showDialog( context,
                            'https://phantom-expansion.unidadeditorial.es/04d5a7930d32e4860ba7cf82291b9d30/resize/640/assets/multimedia/imagenes/2021/03/18/16160714974849.jpg'
                          );
                        }, 
                        size: size, 
                        imgPath: 'https://phantom-expansion.unidadeditorial.es/04d5a7930d32e4860ba7cf82291b9d30/resize/640/assets/multimedia/imagenes/2021/03/18/16160714974849.jpg',
                      ),
                      ImageCard(
                        onPressed: (){
                          _showDialog( context,
                            'https://www.hola.com/imagenes/estar-bien/20190820147813/razas-perros-pequenos-parecen-grandes/0-711-550/razas-perro-pequenos-grandes-m.jpg'
                          );
                        }, 
                        size: size, 
                        imgPath: 'https://www.hola.com/imagenes/estar-bien/20190820147813/razas-perros-pequenos-parecen-grandes/0-711-550/razas-perro-pequenos-grandes-m.jpg',
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only( top: 10, left: 20, right: 20),
                  child: MaterialButton(
                    onPressed: (){},
                    splashColor: Colors.transparent,
                    // minWidth: size.width * 0.05,
                    height: 40,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon( Icons.report, color: Colors.white,),
                        Text( ' Reportar', style: TextStyle( color: Colors.white, fontSize: 17 ),)
                      ],
                    ),
                  ),
                )
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
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint()
      // ..color = Color.fromRGBO(0, 186, 255, 1)
      ..strokeWidth = 15;
    paint.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(0, 186, 255, 1),
        Color.fromRGBO(85, 167, 198, 1),
      ],
    ).createShader(rect);
    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, -size.height);
    path.lineTo(0, -size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}