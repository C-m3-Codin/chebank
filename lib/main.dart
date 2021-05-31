import 'package:chebank/PhoneVerify.dart';
import 'package:chebank/models/CardModel.dart';
import 'package:chebank/models/authProvicer.dart';
import 'package:chebank/pages/CardSelectPage.dart';
import 'package:chebank/pages/FaceRecoog.dart';
import 'package:chebank/pages/FirstScreen.dart';
import 'package:chebank/pages/Login.dart';
import 'package:chebank/pages/ReadQr.dart';
import 'package:chebank/pages/addCard.dart';
import 'package:chebank/pages/test.dart';
import 'package:chebank/services/GetData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// String auth;

String auth;
String email;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth = await FirebaseAuth.instance.currentUser.toString() == "null"
      ? "null"
      : FirebaseAuth.instance.currentUser.email;
  print("\n\n\nEntered\n\n\n\n\n");
  runApp(MyApp());
}

String personAuth;

class MyApp extends StatelessWidget {
  DatabaseService _db = new DatabaseService();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    email = auth;
    print("\n\n\nEntered My App\n\n\n\n\n s$email.s");
    return MultiProvider(
      providers: [
        //  ChangeNotifierProvider<Auth>(
        // create: (_) => Auth(),
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),

        // ChangeNotifierProvider<Selected>(
        // create: (_) => Selected(),
        StreamProvider<List<CardDeets>>(
            create: (BuildContext context) => _db.fetchCards(auth),
            initialData: [])
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: "Bank",
        initialRoute: "/",
        routes: {
          '/': (context) => HomeOrLogin(),
          '/First': (context) => FirstPage(),
          '/QR': (context) => ScanQR(),
          // '/': (context) => DecideLoginPage(),
          '/CardsList': (context) => DisplayCards(),
          '/face': (context) => FaceDetection(),
          '/addCard': (context) => AddAccount(),
          '/face2': (context) => FaceDetectionFromLiveCamera(),
          '/phoneVerify': (context) => PhoneVerify()
        },
      ),
    );
  }
}

// class DecideLoginPage extends StatefulWidget {
//   @override
//   _DecideLoginPageState createState() => _DecideLoginPageState();
// }

// class _DecideLoginPageState extends State<DecideLoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: Center(child: Text("wtf"))),
//     );
//   }
// }
