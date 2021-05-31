import 'dart:async';

import 'package:chebank/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:ipl/main.dart';

signInIdPass(String email, String pass) async {
  try {
    print("\n\n\n\auth in firebase reached\n\n\n\n\n");
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    print("\n\n\n\n\n ${userCredential.user.email} from sign in passa");
    return userCredential;
  } catch (error) {
    print("\n\n\n\n No user \n\n\n\n\n");
  }
}

signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    auth = "null";
    print("\n\n\n\n\n Signed out in auth page\n\n\n");
  } catch (err) {
    print("\n\n\n\nError \n\ne ${err.toString()}\n\n\n\n");
  }
}

returncurrentUser() async {
  final auth = FirebaseAuth.instance.currentUser.email;

  return auth;
}

signedInorNot() {
  return FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}
