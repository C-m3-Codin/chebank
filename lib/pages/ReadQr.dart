import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:chebank/models/CardModel.dart';
import 'package:chebank/services/GetData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScanQR extends StatefulWidget {
  ScanQR({this.card});
  String card;
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.grey[300],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    print("\n\n\n\n${widget.card.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            qrCodeResult != "Not Yet Scanned"
                ? ElevatedButton(
                    onPressed: () {}, child: Text("Naviagate to page"))
                : Container(),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: raisedButtonStyle,
                onPressed: () async {
                  String codeSanner = await BarcodeScanner.scan();
                  try {
                    var res = await FirebaseFirestore.instance
                        .doc('Transcations/$codeSanner')
                        .get();
                    print(res.exists
                        ? '\n\n\n\n\n\n\n\n\n\n exists'
                        : '\n\n\n\n\n\n\n\n\n\n\ndoes not exist');

                    if (res.exists) {
                      DatabaseService db = DatabaseService();

                      String a = db.attachToQe(qrCodeResult, widget.card);

                      // attachToQe()
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Banking(
                                    card: widget.card,
                                  )));
                    }
                    // : null;
                  } catch (err) {
                    print(err);
                  }

                  setState(() {
                    qrCodeResult = codeSanner;
                    print("Scanning");
                  });
                },
                child: Text(
                  "Scan In Bank",
                  style: TextStyle(color: Colors.indigo[900]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Banking extends StatefulWidget {
  String card;
  Banking({this.card});
  @override
  _BankingState createState() => _BankingState();
}

class _BankingState extends State<Banking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(58.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ElevatedButton(
                      onPressed: () {
                        // withdraw
                      },
                      child: Text("withdraw")),
                ),
                Card(
                  child: ElevatedButton(
                      onPressed: () {
                        // withdraw
                      },
                      child: Text("Deposit")),
                ),
                Card(
                  child: ElevatedButton(
                      onPressed: () {
                        // withdraw
                      },
                      child: Text("Transaction History")),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
