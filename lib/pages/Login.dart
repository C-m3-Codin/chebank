import 'package:chebank/pages/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chebank/main.dart';

String email;

class RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => RegisterEmailSectionState();
}

class RegisterEmailSectionState extends State<RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      signUp();
                    }
                  },
                  child: const Text('Register'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      signInIdPass(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(_success == null
                    ? ''
                    : (_success
                        ? 'Successfully registered ' + _userEmail
                        : 'Registration failed')),
              )
            ],
          ),
        ),
      ),
    );
  }

  signInIdPass(String email, String pass) async {
    try {
      print("\n\n\n\auth in firebase reached\n\n\n\n\n");
      final new_user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      print("\n\n\n\n\n ${new_user.user.email} from sign in passa");
      // return userCredential;
      if (new_user != null) {
        print(new_user.user.email);
        email = new_user.user.email;
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
        print(email);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstPage()));
      }
    } catch (error) {
      print("\n\n\n\n No user \n\n\n\n\n");
    }
  }

  Future signUp() async {
    //  FirebaseUser user = await FirebaseAuth.instance;
    _formKey.currentState.save();
    try {
      final new_user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      print("\n\n\n\n\n\n\n\n\n\n\n${new_user.user.email}\n\n\n\n\n\n\n");
      if (new_user != null) {
        email = new_user.user.email;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstPage()));
      }
    } catch (e) {
      print(e);
    }
  }
}
