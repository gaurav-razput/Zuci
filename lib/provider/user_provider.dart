import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _user;
  String _gender;
  String get getUser => _user;
  String get getGender => _gender;

  void refreshUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    _user = user.uid;
    String gen;
    var document = await Firestore.instance.collection('USER').document(_user);
    document.get().then((document) {
      gen = document['gender'];
    }).whenComplete(() {
      _gender = gen;
      if (gen == 'Male') {
        _gender = 'Female';
        print(_gender);
      }
      if (gen == 'Female') {
        _gender = 'Male';
      }
    });
    notifyListeners();
  }
}
