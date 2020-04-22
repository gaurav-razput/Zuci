import 'dart:async';
import'package:firebase_auth/firebase_auth.dart';

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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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

}