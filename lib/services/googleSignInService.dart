import 'dart:convert';


import 'package:flutterapp2/global/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future signInWithGoogle( bool isLogin ) async {
    try{
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account!.authentication;
      
      String path;
      if( isLogin ){
        path = '/login';
      }else{
        path = '/google';
      }
      final signInWithGoogleEndpoint = getPath( path );
      final userData = account;
      final session = await http.post( signInWithGoogleEndpoint, 
        body: {
          'token' : googleKey.idToken,
          'email' : userData.email
        }
      );
      final body = jsonDecode(session.body);
      return body;
      
    }
    catch( error ){
      print('Error en google');
      print( error );
      return null;
    }
  }

  static Future renewToken() async {
    
    try{
      final response = getPath('/renew');
      print(response);
      final isRenewToken = await http.get( response, 
        headers: {
          'Content-Type': 'application/json',
          'token' : await getToken(),
        }
      );
      final body = jsonDecode(isRenewToken.body);
    return body;
    }catch( err ){
      print( err );
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }

  static Future saveToken( token ) async {
    final _storage = FlutterSecureStorage();
    return await _storage.write(key: 'token', value: token);
  }

  static Future deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  static Future getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    print(token);
    return token == null ? '' : token;
  }

  static getPath( pathService ){
    return Uri(
        scheme: Environment.scheme,
        // host: ' http://192.168.1.73:8080/',
        host: Environment.host,
        port: 8080,
        path: '/api/auth' + pathService,
      );
  }
}