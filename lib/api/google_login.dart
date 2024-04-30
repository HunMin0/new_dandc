import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin {
  static Future<String?> login() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication = await account.authentication;

        print('google accessToken: ${authentication.accessToken}');
        return authentication.accessToken;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}