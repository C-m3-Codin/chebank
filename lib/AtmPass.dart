// import 'dart:html';

import 'package:chebank/models/CardModel.dart';
import 'package:chebank/pages/ReadQr.dart';
import 'package:chebank/pages/ShowTransactions.dart';
import 'package:chebank/pages/WithdrawCash.dart';
import 'package:chebank/services/GetData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AtmPass extends StatefulWidget {
  AtmPass({this.card, this.service});
  CardDeets card;
  String service;
  @override
  _AtmPassState createState() => _AtmPassState();
}

class _AtmPassState extends State<AtmPass> {
  String _verificationCode;
  TextEditingController cPinController = new TextEditingController();
  // TextEditingController cOtpController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter Atm Pin'),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(20, 90, 20, 20),
            child: ListView(shrinkWrap: true, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val.length < 4 ? 'Password too short.' : null,
                  obscureText: true,
                  controller: cPinController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Pin',
                    hintText: '4 digit pin Here',
                  ),
                ),
              ),
              Text("${widget.card.password}"),
              // Padding(
              //   padding: EdgeInsets.all(15),
              //   child: TextField(
              //     controller: cNoControl,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Card Number',
              //       hintText: 'Enter Card Number',
              //     ),
              //   ),
              // ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Submit'),
                onPressed: () {
                  print("\n\n\n\n\n\n${widget.card.password}\n\n\n\n\n\n");
                  if (checkPass(cPinController.text)) {
                    // for transaction
                    if (widget.service == "T") {
                      print("\n\n\n\n\n\n${widget.card.password}\n\n\n\n\n\n");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowTransactions(
                                    card: widget.card,
                                  )));
                    }
                    // for withdraw
                    else if (widget.service == "W")
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WithdrawCash(
                                    card: widget.card,
                                  )));

                    // for deposit
                    else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowTransactions(
                                    card: widget.card,
                                  )));
                  } else {
                    final snackBar = SnackBar(
                      content: Text('InCorrect Password'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  print("\n\n\n\n\n\n\n gonna verify");
                  // _verifyPhone(cNumberControl.text);
                },
              ),
            ])));
  }

  bool checkPass(String pasToCheck) {
    if (pasToCheck == widget.card.password) {
      return true;
    }
    return false;
  }

// void signInWithPhoneNumber() async {
// try {
// final AuthCredential credential = PhoneAuthProvider.credential(
// verificationId: _verificationId,
// smsCode: _smsController.text,
// );
//
// final User user = (await _auth.signInWithCredential(credential)).user;
//
// showSnackbar("Successfully signed in UID: ${user.uid}");
// } catch (e) {
// showSnackbar("Failed to sign in: " + e.toString());
// }
// }
}
