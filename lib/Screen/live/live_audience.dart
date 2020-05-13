
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:zuci/Screen/live/live_method.dart';
import 'package:zuci/callScreen/configs/agora_configs.dart';

class Audience extends StatefulWidget {
  final token;
  final uid;
  Audience({this.token,this.uid});
  @override
  _AudienceState createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);
  LiveMethod liveMethod =LiveMethod();
  StreamSubscription liveStreamSubscription;
  addPostFrameLiveback() {
      liveStreamSubscription = liveMethod
          .callStream(uid:widget.uid)
          .listen((DocumentSnapshot ds) {
        switch (ds.data) {
          case null:
            Navigator.pop(context);
            break;

          default:
            break;
        }
      });

  }
  @override
  void initState() {
    super.initState();
    addPostFrameLiveback();
    _initAgoraRtcEngine();
  }
  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create(APP_ID);
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    AgoraRtcEngine.setClientRole(ClientRole.Audience);
    AgoraRtcEngine.enableWebSdkInteroperability(true);
  }
  @override
  void dispose() {
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    liveStreamSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height -10,
                child: AgoraRtcEngine.createNativeView( (viewId) {
                  AgoraRtcEngine.setupRemoteVideo(
                      viewId, VideoRenderMode.Fit, 1);
                  AgoraRtcEngine.joinChannel( null,widget.token, null, 1);
                }),
              ),
            ],
          ),
        );

  }
}
