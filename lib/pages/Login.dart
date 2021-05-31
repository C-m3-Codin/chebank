import 'package:chebank/models/authProvicer.dart';
import 'package:chebank/pages/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chebank/main.dart';
import 'package:provider/provider.dart';

// String email;

class HomeOrLogin extends StatefulWidget {
  @override
  HomeOrLoginState createState() => HomeOrLoginState();
}

class HomeOrLoginState extends State<HomeOrLogin> {
  @override
  Widget build(BuildContext context) {
    print("entered Home Or Login");
    // return Consumer<Auth>(builder: (context, auth, child) {
    // return auth.user.isEmpty ? LoginPage() : ProfilePerson();
    if (auth == "null" || auth.isEmpty) {
      print("\n\n\n\nempty user\n\n\n\n");
      return RegisterEmailSection();
    } else {
      print("\n\n\ $auth <- the user ");
      print("\n\n\n\n\n\n user exists\n\n\n\n\n");
      // return Consumer<GettingDays>(builder: (context, alldays, child) {
      // alldays.tMatches("phome or login page line 26");
      return FirstPage();
      // }
      // );
    }
    // });
  }
}

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                Consumer<Auth>(builder: (context, auths, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () async {
                        await auths.signIn(
                            email: _emailController.text,
                            password: _passwordController.text);
                        if (auths.user.isNotEmpty) {
                          auth = auths.user;
                          print("\n\n\n\n\n\nentered Rerouth");
                          // alldays.tMatches("From Login Page 81");
                          Navigator.popAndPushNamed(context, '/First');
                        }
                      },
                      child: const Text('Login'),
                    ),
                  );
                }),
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   alignment: Alignment.center,
                //   child: RaisedButton(
                //     onPressed: () async {
                //       await auths.signIn(
                //           email: "new email", password: "new Pass");
                //       if (auths.user.isNotEmpty) {
                //         print("\n\n\n\n\n\nentered Rerouth");
                //         // alldays.tMatches("From Login Page 81");
                //         Navigator.popAndPushNamed(context, '/MatchList');
                //       }
                //     },
                //     child: const Text('Login'),
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   child: Text(_success == null
                //       ? ''
                //       : (_success
                //           ? 'Successfully registered ' + _userEmail
                //           : 'Registration failed')),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
