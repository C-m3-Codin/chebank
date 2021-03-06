import 'package:chebank/PhoneVerify.dart';
import 'package:chebank/main.dart';
import 'package:chebank/models/CardModel.dart';
import 'package:chebank/pages/Login.dart';
import 'package:chebank/pages/ReadQr.dart';
import 'package:chebank/services/GetData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayCards extends StatefulWidget {
  @override
  _DisplayCardsState createState() => _DisplayCardsState();
}

class _DisplayCardsState extends State<DisplayCards> {
  @override
  Widget build(BuildContext context) {
    String asd = "apple";

    List<CardDeets> cards = Provider.of<List<CardDeets>>(context).toList();
    // print("\n\n\n\n\n\n card length is ${cards.length}");
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Text(asd),
      //   onPressed: () {
      //     print("\n\n\n\n pressed");
      //     DatabaseService _db = new DatabaseService();
      //     asd = _db.fetchCardsnap();
      //     print("\n\n\n\n\ await over");
      //   },
      // ),
      appBar: AppBar(
        title: Text("Select  Card $auth"),
        actions: [Icon(Icons.person), Text("$auth")],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/atm.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int ind) {
                // print("\n\n\n\n\n\n ${cards[0].toString()}");
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    height: 200,
                    color: Colors.blue[300],
                    child: Card(
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.zero, bottom: Radius.circular(20)),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhoneVerify(card: cards[ind])));
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          color: Colors.yellow[300],
                        ),
                        title: Center(
                            child: Text(
                          cards[ind].cardNo,
                          style: TextStyle(fontSize: 30),
                        )),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
