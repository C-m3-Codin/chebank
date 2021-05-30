import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:ipl/database/LoginAuth.dart';
import 'package:chebank/main.dart';

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
    user = use.user.uid;
    print("\n\n\n$user\n\n\n");
    auth = user;
    print("\n\n\n\n\n\nprovider returned ${user}");
    notifyListeners();
  }

  Future<User> get currentUser async {
    return await returncurrentUser();
  }
}

signInIdPass(String email, String pass) async {
  try {
    print("\n\n\n\auth in firebase reached\n\n\n\n\n");
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "barry.allen@example.com", password: "SuperSecretPassword!");
    print("\n\n\n\n\n ${userCredential.user.email} from sign in passa");
    return userCredential;
  } catch (error) {
    print("\n\n\n\n No user \n\n\n\n\n");
  }
}

returncurrentUser() async {
  final auth = FirebaseAuth.instance;

  return auth.currentUser;
}

void _register() async {
  final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  ))
      .user;
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email;
    });
  } else {
    setState(() {
      _success = true;
    });
  }
}
