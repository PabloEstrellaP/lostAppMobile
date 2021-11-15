import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/models/pet.dart';
import 'package:google_fonts/google_fonts.dart';

class PetCard extends StatelessWidget {
  
  final Size size;
  final Pet data;
  final VoidCallback function;
  
  const PetCard({Key? key, 
    required this.data,
    required this.size,
    required this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(),
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(251, 242, 240, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: this.function,
        child: Card(
          color: Color.fromRGBO(251, 242, 240, 1),
          elevation: 0,
          child: Column(  
            mainAxisSize: MainAxisSize.min,  
            children: <Widget>[  
              Container(
                width: double.infinity, 
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(data.profileImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 2,
                child: Text(data.name, style: GoogleFonts.mcLaren(
                    textStyle: TextStyle(
                      color: Colors.black, 
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
              ),
            ],  
          ),
        ),
      ),
    );   
  }
}

