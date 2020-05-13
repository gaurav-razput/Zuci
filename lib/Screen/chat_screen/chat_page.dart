import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zuci/callScreen/pickup/pickup_layout.dart';
import 'package:zuci/models/message.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/call_methods.dart';
import 'package:zuci/resources/firebase_methods.dart';
import 'package:zuci/utils/call_utilities.dart';
import 'package:zuci/utils/permissions.dart';

class Chat_page extends StatefulWidget {
  final User receiver;
  final User sen;
  Chat_page({
    this.receiver,
    this.sen,
  });

  @override
  _Chat_pageState createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {
  bool isWriting = false;
  TextEditingController textFieldController = TextEditingController();
  FirebaseMethods firebaseMethods = FirebaseMethods();
  CallMethods callMethods = CallMethods();
  bool validate;
  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
//    int min = callMethods.coinBalance(int.parse(userProvider.getUser.coin),int.parse(widget.receiver.callrate));
    int min=1;
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.receiver.name),
          backgroundColor: Colors.purpleAccent,
          elevation: 2.2,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(
                  Icons.video_call,
                ),
                onPressed: () async =>
                    await Permissions.cameraAndMicrophonePermissionsGranted()
                        ? min > 0
                            ? CallUtils.dial(
                                from: userProvider.getUser,
                                to: widget.receiver,
                                context: context,
                              )
                            : Fluttertoast.showToast(
                                msg: 'Less Coin to make Call',
                                timeInSecForIos: 4,
                                textColor: Colors.white,
                                backgroundColor: Colors.purpleAccent)
                        : {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(
                  Icons.phone,
                ),
                onPressed: () async =>
                    await Permissions.cameraAndMicrophonePermissionsGranted()
                        ? CallUtils.voice_dail(
                            from: userProvider.getUser,
                            to: widget.receiver,
                            context: context,
                          )
                        : {},
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: messageList(),
            ),
            chatControls(),
          ],
        ),
      ),
    );
  }

  Widget messageList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("messages")
          .document(userProvider.getUser.uid)
          .collection(widget.receiver.uid)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.documents.length,
          reverse: true,
          itemBuilder: (context, index) {
            return chatMessageItem(snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Container(
        alignment: snapshot['senderId'] == userProvider.getUser.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: snapshot['senderId'] == userProvider.getUser.uid
            ? senderLayout(snapshot)
            : receiverLayout(snapshot),
      ),
    );
  }

  Widget senderLayout(DocumentSnapshot snapshot) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 1),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(snapshot),
      ),
    );
  }

  getMessage(DocumentSnapshot snapshot) {
    return Text(
      snapshot['message'],
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }

  Widget receiverLayout(DocumentSnapshot snapshot) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 1),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(snapshot),
      ),
    );
  }

  Widget chatControls() {
    sendMessage() {
      var text = textFieldController.text;
      textFieldController.clear();
      Message _message = Message(
        receiverId: widget.receiver.uid,
        senderId: userProvider.getUser.uid,
        message: text,
        timestamp: Timestamp.now(),
        type: 'text',
      );

      setState(() {
        isWriting = false;
      });

      FirebaseMethods()
          .addMessageToDb(_message, userProvider.getUser, widget.receiver);
    }

    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    addMediaModal(context) {
      showModalBottomSheet(
          context: context,
          elevation: 0,
          backgroundColor: Colors.white,
          builder: (context) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        child: Icon(
                          Icons.close,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content and tools",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      ModalTile(
                        title: "Media",
                        subtitle: "Share Photos and Video",
                        icon: Icons.image,
                      ),
                      ModalTile(
                          title: "File",
                          subtitle: "Share files",
                          icon: Icons.tab),
                      ModalTile(
                          title: "Contact",
                          subtitle: "Share contacts",
                          icon: Icons.contacts),
                      ModalTile(
                          title: "Location",
                          subtitle: "Share a location",
                          icon: Icons.add_location),
                      ModalTile(
                          title: "Schedule Call",
                          subtitle: "Arrange a skype call and get reminders",
                          icon: Icons.schedule),
                      ModalTile(
                          title: "Create Poll",
                          subtitle: "Share polls",
                          icon: Icons.poll),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                color: Colors.black,
              ),
              onChanged: (val) {
                (val.length > 0 && val.trim() != "")
                    ? setWritingTo(true)
                    : setWritingTo(false);
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.face),
                ),
              ),
            ),
          ),
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.record_voice_over),
                ),
          isWriting ? Container() : Icon(Icons.camera_alt),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 15,
                    ),
                    onPressed: () => {
                      sendMessage(),
                    },
                  ))
              : Container()
        ],
      ),
    );
  }
}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ModalTile({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.purpleAccent,
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: Colors.pink,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.pink,
            fontSize: 14,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
