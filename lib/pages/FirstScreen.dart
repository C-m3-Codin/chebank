import 'package:chebank/main.dart';
import 'package:chebank/pages/Login.dart';
import 'package:chebank/pages/addCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("\n\n\n\n\n\n\n first screen $email");
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $email"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () async {
          print("\n\n\n\n\n Signed out pressed in auth page\n\n\n");

          try {
            await FirebaseAuth.instance.signOut();
            email = "null";
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterEmailSection()));
            print("\n\n\n\n\n Signed out in auth page\n\n\n");
          } catch (err) {
            print("\n\n\n\nError \n\ne ${err.toString()}\n\n\n\n");
          }
        },
      ),
      // appBar: AppBar(
      //   title: Text("ChBank"),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/face');
              //     },

              //     // AddAccount
              //     child: Text("Conduct Transaction")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddAccount()));
                  },
                  child: Text("Add Card")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/face2');
                  },
                  child: Text("Conduct Transaction Live")),

              // /face2
            ],
          ),
        ),
      ),
    );
  }
}
