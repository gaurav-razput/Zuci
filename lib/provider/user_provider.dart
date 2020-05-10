import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/resources/firebase_methods.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseMethods firebaseMethods =FirebaseMethods();
  User _user;
  String _gender;
  User get getUser => _user;
  String get getGender => _gender;

  void refreshUser() async {
    User user = await firebaseMethods.getUserDetails();
    _user = user;
    String gen;
    var document = await Firestore.instance.collection('USER').document(_user.uid);
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
