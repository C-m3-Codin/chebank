// import 'dart:convert';

class CardModel {
  CardModel({
    this.cardNo,
    this.idNo,
    this.balance,
    this.personId,
    this.transactions,
  });

  String cardNo;
  String idNo;
  String balance;
  String personId;
  List<Map<String, String>> transactions;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cardNo: json["cardNo"],
        idNo: json["idNo"],
        balance: json["balance"],
        personId: json["personId"],
        transactions: List<Map<String, String>>.from(json["transactions"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "cardNo": cardNo,
        "idNo": idNo,
        "balance": balance,
        "personId": personId,
        "transactions": List<dynamic>.from(transactions.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
