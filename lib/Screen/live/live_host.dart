//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'dart:async';
//import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//import 'package:provider/provider.dart';
//import 'package:zuci/Screen/live/live_method.dart';
//import 'package:zuci/callScreen/configs/agora_configs.dart';
//import 'package:zuci/provider/user_provider.dart';
//
//class Host extends StatefulWidget {
//  final token;
//  final uid;
//  Host({this.token, this.uid});
//  @override
//  _HostState createState() => _HostState();
//}
//
//class _HostState extends State<Host> {
//  LiveMethod liveMethod = LiveMethod();
//  static final _users = <int>[];
//  final _infoStrings = <String>[];
//  bool muted = false;
//
//  UserProvider userProvider;
//  StreamSubscription liveStreamSubscription;
//  @override
//  void initState() {
//    print('inside initstate host ${widget.uid}');
//    super.initState();
//    addPostFrameCallback();
//    initializeAgora();
//  }
//
//  Future<void> initializeAgora() async {
//    if (APP_ID.isEmpty) {
//      setState(() {
//        _infoStrings.add(
//          'APP_ID missing, please provide your APP_ID in settings.dart',
//        );
//        _infoStrings.add('Agora Engine is not starting');
//      });
//      return;
//    }
//
//    await _initAgoraRtcEngine();
//    _addAgoraEventHandlers();
//    await AgoraRtcEngine.enableWebSdkInteroperability(true);
//    await AgoraRtcEngine.setParameters(
//        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
//    await AgoraRtcEngine.joinChannel(null, widget.token, null, 0);
//
//  }
//
//  addPostFrameCallback() {
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      userProvider = Provider.of<UserProvider>(context, listen: false);
//
//      liveStreamSubscription = liveMethod
//          .callStream(uid: userProvider.getUser.uid)
//          .listen((DocumentSnapshot ds) {
//        // defining the logic
//        switch (ds.data) {
//          case null:
//          // snapshot is null which means that call is hanged and documents are deleted
//            Navigator.pop(context);
//            break;
//          default:
//            break;
//        }
//      });
//    });
//  }
//
//  /// Create agora sdk instance and initialize
//  Future<void> _initAgoraRtcEngine() async {
//    await AgoraRtcEngine.create(APP_ID);
//    await AgoraRtcEngine.enableVideo();
//  }
//
//  /// Add agora event handlers
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
//      liveMethod.endLive(widget.uid);
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
//
//  /// Helper function to get list of native views
//  List<Widget> _getRenderViews() {
//    final List<AgoraRenderWidget> list = [
//      AgoraRenderWidget(0, local: true, preview: true),
//    ];
//    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
//    return list;
//  }
//
//  /// Video view wrapper
//  Widget _videoView(view) {
//    return Expanded(child: Container(child: view));
//  }
//
//  /// Video view row wrapper
//  Widget _expandedVideoRow(List<Widget> views) {
//    final wrappedViews = views.map<Widget>(_videoView).toList();
//    return Expanded(
//      child: Row(
//        children: wrappedViews,
//      ),
//    );
//  }
//
//  /// Video layout wrapper
//  Widget _viewRows() {
//    final views = _getRenderViews();
//    return Container(
//        child: Column(
//          children: <Widget>[_videoView(views[0])],
//        ));
//  }
//
//
//  void _onToggleMute() {
//    setState(() {
//      muted = !muted;
//    });
//    AgoraRtcEngine.muteLocalAudioStream(muted);
//  }
//
//  void _onSwitchCamera() {
//    AgoraRtcEngine.switchCamera();
//  }
//
//  /// Toolbar layout
//  Widget _toolbar() {
//    return Container(
//      alignment: Alignment.bottomCenter,
//      padding: const EdgeInsets.symmetric(vertical: 48),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          RawMaterialButton(
//            onPressed: _onToggleMute,
//            child: Icon(
//              muted ? Icons.mic : Icons.mic_off,
//              color: muted ? Colors.white : Colors.blueAccent,
//              size: 20.0,
//            ),
//            shape: CircleBorder(),
//            elevation: 2.0,
//            fillColor: muted ? Colors.blueAccent : Colors.white,
//            padding: const EdgeInsets.all(12.0),
//          ),
//          RawMaterialButton(
//            onPressed: () => liveMethod.endLive(widget.uid),
//            child: Icon(
//              Icons.call_end,
//              color: Colors.white,
//              size: 35.0,
//            ),
//            shape: CircleBorder(),
//            elevation: 2.0,
//            fillColor: Colors.redAccent,
//            padding: const EdgeInsets.all(15.0),
//          ),
//          RawMaterialButton(
//            onPressed: _onSwitchCamera,
//            child: Icon(
//              Icons.switch_camera,
//              color: Colors.blueAccent,
//              size: 20.0,
//            ),
//            shape: CircleBorder(),
//            elevation: 2.0,
//            fillColor: Colors.white,
//            padding: const EdgeInsets.all(12.0),
//          )
//        ],
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    // clear users
//    _users.clear();
//    // destroy sdk
//    AgoraRtcEngine.leaveChannel();
//    AgoraRtcEngine.destroy();
//    liveStreamSubscription.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.black,
//      body: Center(
//        child: Stack(
//          children: <Widget>[
//            _viewRows(),
//            _toolbar(),
//          ],
//        ),
//      ),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:zuci/callScreen/configs/agora_configs.dart';

class Host extends StatefulWidget {
  final uid;
  final token;
  Host({this.token,this.uid});
  @override
  _HostState createState() => _HostState();
}

class _HostState extends State<Host> {
  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);
  bool muted=false;
  @override
  void initState() {
    super.initState();
    _handleCameraAndMicPermissions();
    _initAgoraRtcEngine();
  }
  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
//            onPressed: () => .endCall(
//              call: widget.call,
//            ),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  _handleCameraAndMicPermissions() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create(APP_ID);
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    AgoraRtcEngine.setClientRole(ClientRole.Broadcaster);
    AgoraRtcEngine.enableWebSdkInteroperability(true);
  }
  @override
  void dispose() {
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height ,
                child: AgoraRtcEngine.createNativeView( (viweId) {
                  AgoraRtcEngine.setupLocalVideo(viweId, VideoRenderMode.Fit);
                  AgoraRtcEngine.startPreview();
                  AgoraRtcEngine.joinChannel(null,widget.token,null, 0);
                }),
              ),
              _toolbar()
            ],
          ),
        );

  }
}
