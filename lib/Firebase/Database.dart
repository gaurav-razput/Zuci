import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zuci/Firebase/user_model.dart';
import 'package:zuci/Message/message_model.dart';


class data_base_methods{

  static final Firestore firestore = Firestore.instance;



  Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
    await firestore.collection("users").getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await firestore
        .collection("messages")
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firestore
        .collection("messages")
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

}