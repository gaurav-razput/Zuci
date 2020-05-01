import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zuci/Screen/callScreen.dart';
import 'package:zuci/callScreen/pickup/audio_call.dart';
import 'package:zuci/models/call.dart';
import 'package:zuci/models/user.dart';
import 'package:zuci/resources/call_methods.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
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

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
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
