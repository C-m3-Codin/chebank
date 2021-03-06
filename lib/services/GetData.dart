import 'dart:convert';

import 'package:chebank/models/CardModel.dart';
import 'package:chebank/pages/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chebank/main.dart';

class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<CardDeets>> fetchCards(String emai) {
    return _db
        .collection(emai)
        // .orderBy("aaa", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((documents) => CardDeets.fromJson(documents.data()))
            .toList());
  }

  addingTransaction(String time, String amount, String cardName) {
    var transaction = {"time": time, "amount": amount};
    FirebaseFirestore.instance.collection(auth).doc(cardName).update({
      "transactions": FieldValue.arrayUnion([transaction])
    });
  }

  attachToQe(String qrCode, CardDeets card) async {
    try {
      print("\n\n\n\nDocument is ${qrCode}");
      await _db
          .collection("Transcations")
          .doc(qrCode)
          .update({"cardNo": card.cardNo, "person": card.personName});
      return "attached";
    } catch (e) {
      print("$qrCode");
      print("Error $e");
      return "Not attached";
    }
  }

  addCard(String cardId, String password, String name, String person,
      String phone) async {
    try {
      print("\n\n\n\nDocument is ${cardId}");
      await _db.collection(auth).doc(cardId).set({
        "cardNo": cardId,
        "pass": password,
        "balance": name,
        "personName": person,
        "phoneNo": phone,
        "id": cardId,
        "balance": "5000",
        "transactions": [
          {"amount": "2000", "time": "Min Bal"}
        ]
      });

      // update({
      //   "cardNo": cardId,
      //   "password": password,
      //   "name": name,
      //   "personName": person
      // });
      return "attached";
    } catch (e) {
      print("$cardId");

      print("Error $e");
      return "Not attached";
    }
  }

  fetchCardsnap() async {
    var a = await _db
        .collection(email)
        .doc("gC1WA0SoBzf0QU6kiSR0")
        .get()
        .then((value) {
      print("\n\n\n\nHere");
      print(value.data()["idNo"]);
    });

    // checkValid
    // .toString();

    print(
        "/n/n\n\n\n\n\n\n pressed value${a.toString()}  and pressed length ${a}");
    return "a";
  }
}
