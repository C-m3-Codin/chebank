import 'package:chebank/models/CardModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowTransactions extends StatefulWidget {
  CardDeets card;
  ShowTransactions({this.card});
  @override
  _ShowTransactionsState createState() => _ShowTransactionsState();
}

class _ShowTransactionsState extends State<ShowTransactions> {
  @override
  Widget build(BuildContext context) {
    // List<CardDeets> cards = Provider.of<List<CardDeets>>(context).toList();
    List<Transaction> trans;
    // cards.forEach((element) {
    //   if (element.cardNo == widget.card.cardNo) {
    //     trans = element.transactions;
    //   }
    // });
    print(
        "\n\n\n\n\n\n\n\n\balance from trans \n${widget.card.transactions.length}\n\n\n\n\n\n\n");
    var balance = 0;
    widget.card.transactions.forEach((element) {
      balance += int.parse(element.amount);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: ListView.builder(
          itemCount: widget.card.transactions.length + 1,
          itemBuilder: (BuildContext context, int ind) {
            if (ind == 0) {
              return Padding(
                padding: const EdgeInsets.all(28.0),
                child: ListTile(
                  title: Text("Balance"),
                  subtitle: Text(balance.toString()),
                ),
              );
            }
            return Card(
              child: ListTile(
                leading: Column(
                  children: [
                    Text("Time"),
                    Text(widget.card.transactions[ind - 1].time),
                  ],
                ),
                title: Column(
                  children: [
                    Text("Amount"),
                    Text(widget.card.transactions[ind - 1].amount),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
