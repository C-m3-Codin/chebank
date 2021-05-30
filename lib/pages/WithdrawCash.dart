import 'package:chebank/models/CardModel.dart';
import 'package:chebank/services/GetData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawCash extends StatefulWidget {
  CardDeets card;
  WithdrawCash({this.card});
  @override
  _WithdrawCashState createState() => _WithdrawCashState();
}

class _WithdrawCashState extends State<WithdrawCash> {
  TextEditingController cCashController = new TextEditingController();
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
                  // maxLength: 4,
                  keyboardType: TextInputType.number,
                  // validator: (val) =>
                  //     val.length < 7 ? 'Password too short.' : null,
                  // obscureText: true,
                  controller: cCashController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount To Withdraw',
                    hintText: 'Enter Amounnt Here',
                  ),
                ),
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
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Withdraw'),
                onPressed: () {
                  print(
                      "\n\n\n\n\n\n\n\n\n\n withdraw pressed\n\n\n\n\n\n\n\n");
                  print(
                      "\n\n\n\n\n\n\n\n\n\n ${widget.card.personName}\n\n\n\n\n\n\n\n");
                  var time = DateFormat.yMEd().add_jms().format(DateTime.now());
                  if (checkAmountPossible(cCashController.text)) {
                    DatabaseService db = new DatabaseService();

                    db.addingTransaction(
                        time, "-" + cCashController.text, widget.card.cardNo);
                    // for transaction
                    final snackBar = SnackBar(
                      content: Text('Take The cash and get a burger'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.popUntil(context, (route) => false);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                          'Cant Withdraw the amount You\'re Too poor for that'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  print("\n\n\n\n\n\n\n gonna verify");
                  // _verifyPhone(cNumberControl.text);
                },
              ),
            ])));
  }

  bool checkAmountPossible(String amount) {
    int balance = 0;
    print("\n\n\n\n${widget.card.transactions.length}\n\n\n\n");

    widget.card.transactions.forEach((element) {
      print("\n\n\n\n\n\n\n\n\ninside transactio\n\n\n\n\n\n\nn");
      balance += int.parse(element.amount);
      print("\n\n\n\n\n\n\n\n\ninside transactio\n\n\n\n\n\n\nn");
    });

    int wanted = int.parse(amount);
    if (wanted > balance) return false;
    return true;
  }
}
