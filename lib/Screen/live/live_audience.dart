import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:zuci/Screen/live/live_method.dart';
import 'package:zuci/callScreen/configs/agora_configs.dart';

class Audience extends StatefulWidget {
  final token;
  final name;
  Audience({@required this.token,@required this.name});
  @override
  _AudienceState createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);
  LiveMethod liveMethod=LiveMethod();
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  @override
  void initState() {
    super.initState();
    _handleCameraAndMicPermissions();
//    _addAgoraEventHandlers();
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

//  void _addAgoraEventHandlers() {
//    AgoraRtcEngine.onError = (dynamic code) {
//      setState(() {
//        final info = 'onError: $code';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onJoinChannelSuccess = (
//        String channel,
//        int uid,
//        int elapsed,
//        ) {
//      setState(() {
//        final info = 'onJoinChannel: $channel, uid: $uid';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
//      setState(() {
//        final info = 'onUserJoined: $uid';
//        _infoStrings.add(info);
//        _users.add(uid);
//      });
//    };
//
//    AgoraRtcEngine.onUpdatedUserInfo = (AgoraUserInfo userInfo, int i) {
//      setState(() {
//        final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onRejoinChannelSuccess = (String string, int a, int b) {
//      setState(() {
//        final info = 'onRejoinChannelSuccess: $string';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onUserOffline = (int a, int b) {
////      liveMethod.endLive(widget.uid);
//    Navigator.pop(context);
//      setState(() {
//        final info = 'onUserOffline: a: ${a.toString()}, b: ${b.toString()}';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onRegisteredLocalUser = (String s, int i) {
//      setState(() {
//        final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onLeaveChannel = () {
//      setState(() {
//        _infoStrings.add('onLeaveChannel');
//        _users.clear();
//      });
//    };
//
//    AgoraRtcEngine.onConnectionLost = () {
//      setState(() {
//        final info = 'onConnectionLost';
//        _infoStrings.add(info);
//      });
//    };
//
//    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
//      // if call was picked
//
//      setState(() {
//        final info = 'userOffline: $uid';
//        _infoStrings.add(info);
//        _users.remove(uid);
//      });
//    };
//
//    AgoraRtcEngine.onFirstRemoteVideoFrame = (
//        int uid,
//        int width,
//        int height,
//        int elapsed,
//        ) {
//      setState(() {
//        final info = 'firstRemoteVideo: $uid ${width}x $height';
//        _infoStrings.add(info);
//      });
//    };
//  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height -10,
                child: AgoraRtcEngine.createNativeView( (viewId) {
                  AgoraRtcEngine.setupRemoteVideo(
                      viewId, VideoRenderMode.Fit, 1);
                  AgoraRtcEngine.joinChannel(null, widget.token, null, 1);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}