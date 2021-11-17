import 'dart:convert';
import 'package:flutterapp2/models/pet.dart';
import 'package:http/http.dart' as http;

import 'package:flutterapp2/global/environment.dart';

class PetService{

  static Future addPet( Pet bodyA ) async {
    try{
      final add = _getPath( '/' );
      final session = await http.post( add, 
        body: bodyA.toJson()
      );

      return jsonDecode( session.body );
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future putPet( Pet bodyA ) async {
    try{
      final add = _getPath( '/' );
      final session = await http.put( add, 
        body: bodyA.toJson()
      );

      return jsonDecode( session.body );
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future deletePet( Pet bodyA ) async {
    try{
      final delete = _getPath( '/' + bodyA.id );
      final session = await http.delete(delete);
      return jsonDecode(session.body);
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future getPet( String id ) async{
    try{
      final get = _getPath( '/' + id );
      final session = await http.get( get );
      return jsonDecode(session.body);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  static Future getPetByUser( String id, isLost ) async{
    try{
      final post = _getPath( '/byUser' );
      final session = await http.post( post, 
        body: {
          'id' : id, 
          'isLost': isLost.toString()
        }
      );

      return jsonDecode(session.body);
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future getPets() async{
    try{
      final get = _getPath( '/' );
      final session = await http.get( get );
      return jsonDecode(session.body);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  static _getPath( pathService ){
    return Uri(
      scheme: Environment.scheme,
      host: Environment.host,
      port: 8080,
      path: '/api/pet' + pathService
    );
  }
}