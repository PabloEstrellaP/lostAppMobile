import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  final _storage = FlutterSecureStorage();
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
        scheme: 'https',
        // host: ' http://192.168.1.73:8080/',
        host: 'lost-puppy-api.herokuapp.com',
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
      if( body['ok']){
        // await this._saveToken( body['token']);
        return body;
      }
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

  Future _saveToken( token ) async {
    return await _storage.write(key: token, value: 'token');
  }

  Future _deleteToken() async {
    await _storage.delete(key: 'token');
  }
}