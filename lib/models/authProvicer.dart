import 'package:chebank/services/autService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
// import 'package:ipl/database/LoginAuth.dart';
// import 'package:ipl/main.dart';

class Auth with ChangeNotifier {
  // final _auth = FirebaseAuth.instance;
  //
  // final auth = FirebaseAuth.instance;
  String user = "";

  Future<void> signOut() async {
    // await signOut();
    notifyListeners();
  }

  Future<void> signIn(
      {@required String email, @required String password}) async {
    // await _auth.signInWithEmailAndPassword(email: email, password: password);
    print("\n\n\n\nProvicer reached \n\n\n\n\n");

    UserCredential use = await signInIdPass(email, password);
    user = use.user.email;
    print("\n\n\n$user\n\n\n");
    auth = user;
    print("\n\n\n\n\n\nprovider returned ${user}");
    notifyListeners();
  }

  Future<User> get currentUser async {
    return await returncurrentUser();
  }
}
