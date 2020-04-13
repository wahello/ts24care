import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';

class GooglePlusService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );
  static GoogleSignInAccount currentUser;
  static Future<bool> handleSignIn() async {
    bool result = false;
    try {
      return _googleSignIn.signIn().then((onValue) {
        print('onvalue $onValue');
        if (onValue != null) {
          currentUser = onValue;
          print('urlPhoto ${GooglePlusService.currentUser.photoUrl}');
          result = true;
        } else {
          print('null');
          currentUser = null;
        }
        return result;
      });
    } catch (error) {
      print('error $e');
      return result;
    }
  }

  static Future<void> handleSignOut() async {
    if (currentUser != null) {
      await _googleSignIn.disconnect();
      currentUser = null;
    }
  }
}
