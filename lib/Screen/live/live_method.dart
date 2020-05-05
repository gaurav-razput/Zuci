import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanoid/nanoid.dart';
import 'package:zuci/constants/strings.dart';

class LiveMethod {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference liveCollection =
  Firestore.instance.collection(LIVE_COLLECTION);
  Stream<DocumentSnapshot> callStream({String uid}) =>
      liveCollection.document(uid).snapshots();


  Future<String> GoLiveMethod(user_uid,name) async {
    String token=nanoid(7);
    DocumentReference documentReference = _firestore.document('live/$user_uid');
    Map<String, String> info = <String, String>{
      'uid': '$user_uid',
      'name':'$name',
      'token': "$token",
    };
    await documentReference.setData(info).whenComplete((){
      return token;
    });
  }

  Future<bool> endlive(uid) async {
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
