import 'dart:convert';
import 'package:flutterapp2/models/reports.dart';
import 'package:flutterapp2/models/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutterapp2/global/environment.dart';

class ReportsService{

  static Future getReports( User user) async {
    try{
      final get = _getPath( '/' + user.id );
      final session = await http.get( get );

      return jsonDecode( session.body );
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future addReports( Report report) async {
    try{
      final get = _getPath( '/' );
      final session = await http.post( get, 
        body: report.toJson()
      );

      return jsonDecode( session.body );
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future getChat( Report report ) async {
    try{
      final get = Uri(
        scheme: Environment.scheme,
        host: Environment.host,
        // port: 8080,
        path: '/api/report/chat/user/',
        queryParameters: {
          "id": report.pet.id,
          "myId": report.to.id,
          "msgFrom": report.from.id
        }
      );
      final session = await http.get( get );

      return jsonDecode( session.body );
    }catch(e){
      print(e);
      return null;
    }
  }

  static _getPath( pathService ){
    return Uri(
      scheme: Environment.scheme,
      host: Environment.host,
      // port: 8080,
      path: '/api/report' + pathService
    );
  }
}