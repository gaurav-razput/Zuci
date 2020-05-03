
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zuci/constants/strings.dart';
import 'package:zuci/models/contact.dart';
import 'package:zuci/models/message.dart';
import 'package:zuci/models/user.dart';


class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  static final Firestore _firestore = Firestore.instance;


  final CollectionReference _messageCollection =
  Firestore.instance.collection(MESSAGES_COLLECTION);

//  StorageReference _storageReference;

  //user class
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();

    return User.fromMap(documentSnapshot.data);
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<void> addDataToDb(uid,email,username,) async {

    user = User(
        uid: uid,
        email:email,
        name: username,
        profilePhoto: "",
         );

    firestore
        .collection(USERS_COLLECTION)
        .document(uid)
        .setData(user.toMap(user));
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).getDocuments();
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

    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToContacts(senderId: message.senderId, receiverId: message.receiverId);

    return await _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  addToContacts({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId, receiverId, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) => _userCollection
      .document(userId)
      .collection(CONTACTS_COLLECTION)
      .snapshots();
  Stream<QuerySnapshot> fetchSubscribe({String userId}) => _userCollection
      .document(userId)
      .collection(SUBSCRIPTION_COLLECTION)
      .snapshots();

  DocumentReference getContactsDocument({String of, String forContact}) =>
      _userCollection
          .document(of)
          .collection(CONTACTS_COLLECTION)
          .document(forContact);

  Future<void> addToSenderContacts(
      String senderId,
      String receiverId,
      currentTime,
      ) async {
    DocumentSnapshot senderSnapshot =
    await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      Contact receiverContact = Contact(
        uid: receiverId,
        addedOn: currentTime,
      );

      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(of: senderId, forContact: receiverId)
          .setData(receiverMap);
    }
  }

  Future<void> addToReceiverContacts(
      String senderId,
      String receiverId,
      currentTime,
      ) async {
    DocumentSnapshot receiverSnapshot =
    await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Contact senderContact = Contact(
        uid: senderId,
        addedOn: currentTime,
      );

      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .setData(senderMap);
    }
  }

  Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      _messageCollection
          .document(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
//  Future<String> uploadImageToStorage(File imageFile) async {
//    // mention try catch later on
//
//    try {
//      _storageReference = FirebaseStorage.instance
//          .ref()
//          .child('${DateTime.now().millisecondsSinceEpoch}');
//      StorageUploadTask storageUploadTask =
//          _storageReference.putFile(imageFile);
//      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
//      // print(url);
//      return url;
//    } catch (e) {
//      return null;
//    }
//  }


  Future<User> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
      await _userCollection.document(id).get();
      return User.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<void> addCoin(uid,addcoins) async{
    print('Add coin is called');
    print(uid);
    String coin;
    var document = await Firestore.instance.collection('USER').document(uid);
    document.get().then((document){
      coin=document['Coins'];
      print('Previous coin is $coin');
    }).whenComplete((){
      Firestore.instance
          .collection('USER')
          .document('$uid')
          .updateData({
        'Coins': '${int.parse(coin)+addcoins}',
      });
      print('coins after update ${int.parse(coin)+addcoins}');
    });

  }

  Future<void> addsubscription(of,to){
    print('Add subscription method is called ');
    Map<String, String> info = <String, String>{
      'of':of,
      'to':to
    };
    _userCollection
        .document(of)
        .collection(SUBSCRIPTION_COLLECTION)
        .document(to).setData(info);
  }

  Future<bool> issubscribe(of,to) async {
    var document = await Firestore.instance.collection('USER').document(of).collection(SUBSCRIPTION_COLLECTION).document(to).get();
    print('is subscribe${document.exists}');
    if(document.exists){
      return true;
    }
    return false;
  }

//  void uploadImage(File image, String receiverId, String senderId,
//      ImageUploadProvider imageUploadProvider) async {
//    // Set some loading value to db and show it to user
//    imageUploadProvider.setToLoading();
//
//    // Get url from the image bucket
//    String url = await uploadImageToStorage(image);
//
//    // Hide loading
//    imageUploadProvider.setToIdle();
//
//    setImageMsg(url, receiverId, senderId);
//  }
}
