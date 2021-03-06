// https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart
import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/shared/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:letsmuk/screens/homepage/index.dart';

import 'call.dart';

class VideoCallHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<VideoCallHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: onJoin,
                    child: Text('Start Call'),
                    // color: Colors.blueAccent,
                    // textColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: AGORA_CHANNEL_NAME,
          role: ClientRole.Broadcaster,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
