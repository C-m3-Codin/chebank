import 'package:chebank/models/CardModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        // transactions
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowTransactions(
                                      cardNo: widget.card,
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

class ShowTransactions extends StatefulWidget {
  String cardNo;
  ShowTransactions({this.cardNo});
  @override
  _ShowTransactionsState createState() => _ShowTransactionsState();
}

class _ShowTransactionsState extends State<ShowTransactions> {
  @override
  Widget build(BuildContext context) {
    List<CardDeets> cards = Provider.of<List<CardDeets>>(context).toList();
    List<Transaction> trans;
    cards.forEach((element) {
      if (element.cardNo == widget.cardNo) {
        trans = element.transactions;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: ListView.builder(
          itemCount: trans.length,
          itemBuilder: (BuildContext context, int ind) {
            return Card(
              child: ListTile(
                leading: Text(trans[ind].time),
                title: Text(trans[ind].amount),
              ),
            );
          }),
    );
  }
}
