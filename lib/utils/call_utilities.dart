import 'dart:math';
import 'package:flutter/material.dart';

import 'package:zuci/Screen/callScreen.dart';
import 'package:zuci/callScreen/pickup/audio_call.dart';
import 'package:zuci/models/call.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/resources/call_methods.dart';
import 'package:zuci/resources/firebase_methods.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();
  static final FirebaseMethods firebaseMethods=FirebaseMethods();
  static dial({User from, User to, context}) async {
    firebaseMethods.adddailhistory(from.uid, to.uid);
    firebaseMethods.addrechistory(from.uid, to.uid);
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
      callRate: to.callrate
    );
    bool callMade = await callMethods.makeCall(call: call);
    call.hasDialled = true;
    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call,from: from,),
          ));
    }
  }
  static voice_dail({User from, User to, context}) async{
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );
    bool callMade = await callMethods.makeCall(call: call);
    call.hasDialled = true;
    call.isvoicecall=true;
    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => audio_call_screen(call: call),
          ));
    }
  }
}
