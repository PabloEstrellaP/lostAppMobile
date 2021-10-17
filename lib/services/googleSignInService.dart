import 'dart:convert';

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
        path = '/api/auth/login';
      }else{
        path = '/api/auth/google';
      }
      final signInWithGoogleEndpoint = Uri(
        scheme: 'http',
        // host: ' http://192.168.1.73:8080/',
        host: '192.168.1.73',
        port: 8080,
        path: path,
      );
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
    return await _storage.read(key: 'token');
  }
}