import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _user;

  String get getUser => _user;

  void refreshUser() async {
    FirebaseUser user=await _firebaseAuth.currentUser();
    _user=user.uid;
    notifyListeners();
  }

}
