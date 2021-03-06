import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/screens/videocall/call.dart';
import 'package:letsmuk/shared/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  Future<void> joinRoom(context) async {
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
