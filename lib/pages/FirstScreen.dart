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
                  child: Text("Comduct Transaction")),
              ElevatedButton(onPressed: () {}, child: Text("Add Card")),
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
