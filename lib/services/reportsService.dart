import 'dart:convert';
import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/models/reports.dart';
import 'package:http/http.dart' as http;

import 'package:flutterapp2/global/environment.dart';

class ReportsService{

  static Future getReports() async {
    try{
      final get = _getPath( '/' );
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

  static Future getChat( /*Report report*/ ) async {
    try{
      final get = _getPath( '/chat/user/6189b925b416c16f3c599213' /*+ report.id*/ );
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
      port: 8080,
      path: '/api/report' + pathService
    );
  }
}