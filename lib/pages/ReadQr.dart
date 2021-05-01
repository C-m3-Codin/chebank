import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:chebank/models/CardModel.dart';
import 'package:flutter/material.dart';
import 'package:chebank/services/GetData.dart';

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
            Container(
                child: qrCodeResult == "Not Yet Scanned"
                    ? Text("")
                    : ElevatedButton(
                        onPressed: () {
                          // atttach card id to bank qr id
                          //
                          //
                          DatabaseService db = DatabaseService();
                          db.attachToQe(qrCodeResult, widget.card);
                        },
                        child: Text("Proceed With Transcation")))
          ],
        ),
      ),
    );
  }
}
