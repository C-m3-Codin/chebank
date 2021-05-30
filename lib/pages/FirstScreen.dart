import 'package:chebank/pages/addCard.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("ChBank"),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/face');
                  },

                  // AddAccount
                  child: Text("Comduct Transaction")),
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
                  child: Text("Comduct Transaction Live")),

              // /face2
            ],
          ),
        ),
      ),
    );
  }
}
