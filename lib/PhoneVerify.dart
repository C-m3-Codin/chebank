// import 'dart:html';

import 'package:chebank/models/CardModel.dart';
import 'package:chebank/pages/ReadQr.dart';
import 'package:chebank/services/GetData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneVerify extends StatefulWidget {
  PhoneVerify({this.card});
  CardDeets card;
  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  String _verificationCode;
  TextEditingController cNumberControl = new TextEditingController();
  TextEditingController cOtpController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _verifyPhone(this.widget.card.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Add Card ${widget.card.personName + widget.card.password}'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(15), child: Text("Verifing Otp")),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: CircularProgressIndicator()

                    // TextField(
                    //   controller: cNumberControl,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Card Name',
                    //     hintText: 'Enter a Card Name',
                    //   ),
                    // ),
                    ),
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
                // RaisedButton(
                //   textColor: Colors.white,
                //   color: Colors.blue,
                //   child: Text('Verify Otp'),
                //   onPressed: () {
                //     print("\n\n\n\n\n\n\n gonna verify");
                //     _verifyPhone(this.widget.card.phone);
                //   },
                // ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: cOtpController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter otp',
                      hintText: 'Otp enter',
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Save'),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode,
                              smsCode: cOtpController.text))
                          .then((value) async {
                        if (value.user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ScanQR(card: widget.card)),
                              (route) => false);
                        }
                      });
                    } catch (e) {
                      print("\n\n\n\n\n\n\n\n ${e.toString()}");
                    }
                  },
                )
              ],
            )));
  }

  _verifyPhone(String number) async {
    print("\n\n\n\n\n\n\n\n\n number is $number \n\n\n\n\n\n");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ScanQR()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          print("\n\n\n\n\n\n\n gonna send verify id");
          print("\n\n\n\n\n\n\n verify id is ${verficationID}");
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
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
