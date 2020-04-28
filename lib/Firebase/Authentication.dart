import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:zuci/Firebase/user_model.dart';

abstract class firebase_methods{
  //firebase signin
  Future<String> signIn(String email, String password);

  //firebase signup
  Future<String> signUp(String email, String password);

  //method to get current user
  Future<FirebaseUser> getCurrentUser();

  //method to signout the user
  Future<void> signOut();


}

class auth implements firebase_methods{

  bool loading;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;

  static final CollectionReference _userCollection =
  _firestore.collection('USER');





  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
    await _userCollection.document(currentUser.uid).get();

    return User.fromMap(documentSnapshot.data);
  }

}