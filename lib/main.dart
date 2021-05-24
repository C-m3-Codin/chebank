import 'package:chebank/models/CardModel.dart';
import 'package:chebank/pages/CardSelectPage.dart';
import 'package:chebank/pages/FaceRecoog.dart';
import 'package:chebank/pages/FirstScreen.dart';
import 'package:chebank/pages/ReadQr.dart';
import 'package:chebank/pages/test.dart';
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
        initialRoute: "/First",
        routes: {
          '/First': (context) => FirstPage(),
          '/QR': (context) => ScanQR(),
          '/': (context) => DecideLoginPage(),
          '/CardsList': (context) => DisplayCards(),
          '/face': (context) => FaceDetection(),
          '/face2': (context) => FaceDetectionFromLiveCamera()
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
