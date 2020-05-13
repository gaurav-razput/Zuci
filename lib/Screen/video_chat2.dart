import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/chat_screen/chat_page.dart';
import 'package:zuci/constants/strings.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/call_methods.dart';
import 'package:zuci/resources/firebase_methods.dart';
import 'package:zuci/utils/call_utilities.dart';
import 'package:zuci/utils/permissions.dart';

class NxtVideoChat extends StatefulWidget {
  @required
  final User receiver;
  @required
  final User sender;
  NxtVideoChat({this.receiver, this.sender});

  @override
  _NxtVideoChatState createState() => _NxtVideoChatState();
}

class _NxtVideoChatState extends State<NxtVideoChat> {
  FirebaseMethods firebaseMethods = FirebaseMethods();
  CallMethods callMethods = CallMethods();
  bool loading = true;
  bool _issubscribe;
  Future<void> check_subscription() async {
    _issubscribe = await firebaseMethods.issubscribe(
        widget.sender.uid, widget.receiver.uid);
  }

  @override
  void initState() {
    _issubscribe = false;
    super.initState();
    check_subscription().whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
//    int min = callMethods.coinBalance(int.parse(userProvider.getUser.coin),
//        int.parse(widget.receiver.callrate));
    int min=1;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: ListView(
              children: <Widget>[
                LayoutBuilder(
                  builder: (ctx, constraint) {
                    return Container(
                      height: size.height * .45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: widget.receiver.profilePhoto == null
                              ? AssetImage('assets/Image/person.png')
                              : NetworkImage(widget.receiver.profilePhoto),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            //For Back Button
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFFF5F5F5),
                                  size: 30,
                                ),
                              ),
                            ),
                            //For Name Id On Picture
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: constraint.maxWidth * .5,
                                      child: Text(
                                        "${widget.receiver.name}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "${widget.receiver.age}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(
                                          constraint.maxWidth * .02),
                                      child: Text(
                                        "${widget.receiver.country}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(
                                          constraint.maxWidth * .02),
                                      child: Text(
                                        "Zuci ID:${widget.receiver.id}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                //For Buttons
                Container(
                  margin: EdgeInsets.all(size.height * .01),
                  height: size.height * .05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      LayoutBuilder(
                        builder: (ctx, constraint) {
                          return GestureDetector(
                            onTap: () async {
                              if (_issubscribe) {
                                print(userProvider.getUser.uid);
                                await Firestore.instance
                                    .collection(USERS_COLLECTION)
                                    .document(userProvider.getUser.uid)
                                    .collection(SUBSCRIPTION_COLLECTION)
                                    .document(widget.receiver.uid)
                                    .delete()
                                    .whenComplete(() {
                                  setState(() {
                                    _issubscribe = false;
                                  });
                                });
                              } else {
                                firebaseMethods.addsubscription(
                                    userProvider.getUser.uid,
                                    widget.receiver.uid);
                                setState(() {
                                  _issubscribe = true;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(_issubscribe
                                        ? Icons.remove
                                        : Icons.add),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        _issubscribe
                                            ? 'Unsubscribe'
                                            : 'Subscribe',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.white10,
                                ),
                                // color: Colors.black26,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.2, 1],
                                  colors: [
                                    Color(0xFFB44EB1),
                                    Color(0xFFDA4D91)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      LayoutBuilder(
                        builder: (ctx, constraint) {
                          return GestureDetector(
                            onTap: () async => await Permissions
                                    .cameraAndMicrophonePermissionsGranted()
                                ? CallUtils.voice_dail(
                                    from: userProvider.getUser,
                                    to: widget.receiver,
                                    context: context,
                                  )
                                : {},
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.phone),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Voice Call',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.white10,
                                ),
                                // color: Colors.black26,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.2, 1],
                                  colors: [
                                    Color(0xFFB44EB1),
                                    Color(0xFFDA4D91)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      LayoutBuilder(
                        builder: (ctx, constraint) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat_page(
                                            receiver: widget.receiver,
                                            sen: userProvider.getUser,
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.message),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Say Hi',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.white10,
                                ),
                                // color: Colors.black26,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.2, 1],
                                  colors: [
                                    Color(0xFFB44EB1),
                                    Color(0xFFDA4D91)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                //Profile and other Information
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * .05,
                    right: size.width * .05,
                    top: size.height * .01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                      items("Score", "5 Star"),
                      items("Biography", "${widget.receiver.bio}"),
                      items("Price", "${widget.receiver.callrate} points/min"),
                      items("Online Time", "${widget.receiver.onlinetime}"),
                      items("Local Time", "01-21-20 15:59:39"),
                      items("Probability", "100%"),
                      items("Grand Total", "994 minutes(s)"),
                      //Video Call Button ------------x----x----xx-------x----------x----------x------------x-----------x------------
                      InkWell(
                        onTap: () async => await Permissions
                                .cameraAndMicrophonePermissionsGranted()
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
                        child: Container(
                          margin: EdgeInsets.only(top: size.height * .025),
                          height: size.height * .07,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * .05),
                                  child: Text(
                                    'Video Call Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.white10,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.2, 1],
                              colors: [Color(0xFFB44EB1), Color(0xFFDA4D91)],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Center(
            child: loading ? CircularProgressIndicator() : Container(),
          )
        ],
      ),
    );
  }

  //profile and details widgets
  Widget items(ques, ans) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            ques,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            ans,
            style: TextStyle(fontSize: 16, color: Color(0xFF686868)),
          ),
        ],
      ),
    );
  }
}
