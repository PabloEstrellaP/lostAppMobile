import 'dart:convert';
import 'package:flutterapp2/models/pet.dart';
import 'package:http/http.dart' as http;

import 'package:flutterapp2/global/environment.dart';

class PetService{

  static Future addPet( Pet bodyA ) async {
    try{
      
      final add = getPath( '/' );
      final session = await http.post( add, 
        body: bodyA.toJson()
      );

      return jsonDecode( session.body );
    }catch(e){
      print(e);
      return null;
    }
  }

  static getPath( pathService ){
    return Uri(
      scheme: Environment.scheme,
      host: Environment.host,
      port: 8080,
      path: '/api/pet' + pathService
    );
  }
}