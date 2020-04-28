import 'package:flutter/material.dart';

import 'package:zuci/Call/call_method.dart';
import 'package:zuci/Call/call_method2.dart';
import 'package:zuci/Call/call_model.dart';
import 'package:zuci/Call/video_call/call-screen.dart';
import 'package:zuci/Permissions.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  // ignore: non_constant_identifier_names
  final user_uid;
  final CallMethods callMethods = CallMethods();

  PickupScreen({
    @required this.call,
    this.user_uid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
//            CachedImage(
//              call.callerPic,
//              isRound: true,
//              radius: 180,
//            ),
            SizedBox(height: 15),
            Text(
              call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () async =>
                  await Permissions.cameraAndMicrophonePermissionsGranted()
                      ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallScreen(call: call),
                    ),
                  )
                      : {},
//                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen(call:call,user_uid: user_uid,))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
