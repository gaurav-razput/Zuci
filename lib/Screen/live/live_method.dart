import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:zuci/Screen/live/live_host.dart';
import 'package:zuci/constants/strings.dart';

class LiveMethod {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference liveCollection =
  Firestore.instance.collection(LIVE_COLLECTION);
  Stream<DocumentSnapshot> callStream({String uid}) =>
      liveCollection.document(uid).snapshots();


  Future<String> GoLiveMethod(userUid,gender,name,age,country,context) async {
    String token=nanoid(7);
    DocumentReference documentReference = _firestore.document('$LIVE_COLLECTION/$userUid');
    Map<String, String> info = <String, String>{
      'uid': '$userUid',
      'token': "$token",
      'gender':"$gender",
      'name':"$name",
      'age':"$age",
      'country':'$country'
    };
    await documentReference.setData(info)
      .whenComplete(() {
      Navigator.push(
      context, MaterialPageRoute(builder: (context) => Host(uid: userUid,token: token,)));
      });

  }

  Future<bool> endLive(uid) async {
    print('Endlive method is callec$uid');
    try {
      await liveCollection.document(uid).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}
