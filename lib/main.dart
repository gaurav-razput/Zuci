import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zuci/Firebase/Authentication.dart';
import 'package:zuci/Pages/check_auth_page.dart';
import 'package:zuci/Pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zuci',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyhomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyhomePage extends StatefulWidget {

  MyhomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final firebase_methods auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _auth.currentUser().asStream(),
        builder: (context, snapshot) {
          return snapshot.hasData ? MainPage() : Check_Status(auth: new auth());
        });
  }
}
