// To parse this JSON data, do
//
//     final cardDeets = cardDeetsFromJson(jsonString);

import 'dart:convert';

CardDeets cardDeetsFromJson(String str) => CardDeets.fromJson(json.decode(str));

String cardDeetsToJson(CardDeets data) => json.encode(data.toJson());

class CardDeets {
  CardDeets(
      {this.balance,
      this.personName,
      this.id,
      this.cardNo,
      this.transactions,
      this.password});

  String balance;
  String personName;
  String password;
  String id;
  String cardNo;
  List<Transaction> transactions;

  factory CardDeets.fromJson(Map<String, dynamic> json) => CardDeets(
        balance: json["balance"],
        personName: json["personName"],
        id: json["id"],
        password: json["pass"],
        cardNo: json["cardNo"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "personName": personName,
        "id": id,
        "cardNo": cardNo,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.amount,
    this.time,
  });

  String amount;
  String time;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "time": time,
      };
}
