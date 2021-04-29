import 'package:chebank/models/CardModel.dart';
import 'package:chebank/services/GetData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // auth = await FirebaseAuth.instance.currentUser.toString() == "null"
  //     ? "null"
  //     : FirebaseAuth.instance.currentUser.uid;
  // print("\n\n\nEntered\n\n\n\n\n");
  runApp(MyApp());
}

String personAuth;

class MyApp extends StatelessWidget {
  DatabaseService _db = new DatabaseService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<CardModel>>(
            create: (BuildContext context) => _db.fetchCards(), initialData: [])
      ],
      child: MaterialApp(
        title: "Bank",
        initialRoute: "/CardsList",
        routes: {
          '/': (context) => DecideLoginPage(),
          '/CardsList': (context) => DisplayCards()
        },
      ),
    );
  }
}

class DecideLoginPage extends StatefulWidget {
  @override
  _DecideLoginPageState createState() => _DecideLoginPageState();
}

class _DecideLoginPageState extends State<DecideLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DisplayCards extends StatefulWidget {
  @override
  _DisplayCardsState createState() => _DisplayCardsState();
}

class _DisplayCardsState extends State<DisplayCards> {
  @override
  Widget build(BuildContext context) {
    String asd = "apple";
    List<CardModel> cards = Provider.of<List<CardModel>>(context).toList();
    // print("\n\n\n\n\n\n card length is ${cards.length}");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(asd),
        onPressed: () {
          print("\n\n\n\n pressed");
          DatabaseService _db = new DatabaseService();
          asd = _db.fetchCardsnap();
          print("\n\n\n\n\ await over");
        },
      ),
      appBar: AppBar(
        title: Text("Cards Select"),
      ),
      body: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int ind) {
            // print("\n\n\n\n\n\n ${cards[0].toString()}");
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 200,
                color: Colors.blue[300],
                child: Card(
                  color: Colors.blue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.zero, bottom: Radius.circular(20)),
                  ),
                  child: ListTile(
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
                    // subtitle: Text("asd"),
                    // subtitle: Column(
                    //   children: [Text("Balance"), Text(cards[ind].balance)],
                    // ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
