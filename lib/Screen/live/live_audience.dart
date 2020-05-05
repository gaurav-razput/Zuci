import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:zuci/callScreen/configs/agora_configs.dart';

class Audience extends StatefulWidget {
  @override
  _AudienceState createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);

  @override
  void initState() {
    super.initState();
    _handleCameraAndMicPermissions();
    _initAgoraRtcEngine();
  }

  _handleCameraAndMicPermissions() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create(APP_ID);
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    AgoraRtcEngine.setClientRole(ClientRole.Audience);
    AgoraRtcEngine.enableWebSdkInteroperability(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 120,
                child: AgoraRtcEngine.createNativeView( (viewId) {
                  AgoraRtcEngine.setupRemoteVideo(
                      viewId, VideoRenderMode.Fit, 1);
                  AgoraRtcEngine.joinChannel(null, 'flutter', null, 1);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}