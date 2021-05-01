import 'dart:convert';

import 'package:chebank/models/CardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chebank/main.dart';

class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<CardModel>> fetchCards() {
    return _db
        .collection("Person1")
        // .orderBy("aaa", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((documents) => CardModel.fromJson(documents.data()))
            .toList());
  }

  attachToQe(String qrCode, String cardId) {
    try {
      print("\n\n\n\nDocument is ${qrCode}");
      _db.collection("Transcations").doc(qrCode).update({"cardNo": cardId});
    } catch (e) {
      print("Error $e");
    }
  }

  fetchCardsnap() async {
    var a = await _db
        .collection("Person1")
        .doc("gC1WA0SoBzf0QU6kiSR0")
        .get()
        .then((value) {
      print("\n\n\n\nHere");
      print(value.data()["idNo"]);
    });
    // .toString();

    print(
        "/n/n\n\n\n\n\n\n pressed value${a.toString()}  and pressed length ${a}");
    return "a";
  }
}
