import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nanoid/generate.dart';
import 'package:zuci/Call/call_method.dart';
import 'package:zuci/Call/call_method2.dart';
import 'package:zuci/Call/call_model.dart';
import 'package:zuci/Call/video_call/call-screen.dart';
import 'package:zuci/Firebase/user_model.dart';

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
      channelId: generate('abcdefgh1234567890', 8),
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
}
