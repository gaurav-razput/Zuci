import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/resources/firebase_methods.dart';

class UserProvider with ChangeNotifier {
   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseMethods _firebaseMethods =FirebaseMethods();
  String _user;

  String get getUser => _user;

  void refreshUser() async {
    FirebaseUser user=await _firebaseAuth.currentUser();
    _user=user.uid;
    notifyListeners();
  }

}
