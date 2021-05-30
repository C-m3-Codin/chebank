import 'package:chebank/services/GetData.dart';
import 'package:flutter/material.dart';

class AddAccount extends StatefulWidget {
  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  TextEditingController cNameControl = new TextEditingController();
  TextEditingController cNoControl = new TextEditingController();
  TextEditingController cHolderControl = new TextEditingController();
  TextEditingController cPassControl = new TextEditingController();
  TextEditingController cphoneNumber = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Card Details'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: cHolderControl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Name',
                      hintText: 'Enter a Card Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: cNoControl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Number',
                      hintText: 'Enter Card Number',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: cNameControl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holders Name',
                      hintText: 'Enter Card Holders Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: cPassControl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card password ',
                      hintText: 'Enter passwped',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: cphoneNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number ',
                      hintText: 'Enter Phone Number',
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Save'),
                  onPressed: () {
                    print("${cHolderControl.text}");
                    DatabaseService _db = new DatabaseService();
                    _db.addCard(
                        cNoControl.text,
                        cPassControl.text,
                        cNameControl.text,
                        cHolderControl.text,
                        cphoneNumber.text);
                  },
                )
              ],
            )));
  }
}
