import 'package:chebank/AtmPass.dart';
import 'package:chebank/models/CardModel.dart';
import 'package:chebank/pages/ShowTransactions.dart';
import 'package:chebank/services/GetData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Banking extends StatefulWidget {
  CardDeets card;
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
                        DatabaseService db = new DatabaseService();
                        // db.addingTransaction("2", "+234", widget.card.cardNo);
                        // withdraw

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtmPass(
                                      card: widget.card,
                                      service: "W",
                                    )));
                      },
                      child: Text("withdraw")),
                ),
                Card(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtmPass(
                                      card: widget.card,
                                      service: "D",
                                    )));
                        // withdraw
                      },
                      child: Text("Deposit")),
                ),
                Card(
                  child: ElevatedButton(
                      onPressed: () {
                        // transactions
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtmPass(
                                      card: widget.card,
                                      service: "T",
                                    )));
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
