import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuci/Screen/callScreen.dart';
import 'package:zuci/callScreen/pickup/audio_call.dart';
import 'package:zuci/models/call.dart';
import 'package:zuci/provider/user_provider.dart';
import 'package:zuci/resources/call_methods.dart';
import 'package:zuci/utils/permissions.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({
    @required this.call,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
              '${call.callerName}',
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
                          ?
//                      call.isvoicecall?Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => audio_call_screen(call: call),
//                        ),
//                      ):
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallScreen(call: call,from:userProvider.getUser,),
                              ),
                            )
                          : {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
