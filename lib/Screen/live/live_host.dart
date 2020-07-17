import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:zuci/Screen/live/live_method.dart';
import 'package:zuci/callScreen/configs/agora_configs.dart';

class Host extends StatefulWidget {
  final uid;
  final token;
  Host({this.token, this.uid});
  @override
  _HostState createState() => _HostState();
}

class _HostState extends State<Host> {
  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);
  LiveMethod liveMethod = LiveMethod();
  bool muted = false;
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
            onPressed: () async  {
              await liveMethod.endLive(widget.uid).whenComplete((){
                Navigator.pop(context);
              });
              print('end button is press');
            },
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
            height: MediaQuery.of(context).size.height,
            child: AgoraRtcEngine.createNativeView((viweId) {
              AgoraRtcEngine.setupLocalVideo(viweId, VideoRenderMode.Fit);
              AgoraRtcEngine.startPreview();
              AgoraRtcEngine.joinChannel(null, widget.token, null, 0);
            }),
          ),
          _toolbar()
        ],
      ),
    );
  }
}
