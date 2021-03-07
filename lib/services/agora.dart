import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/screens/videocall/call.dart';
import 'package:letsmuk/shared/constants.dart';
import 'package:letsmuk/shared/utils.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:http/http.dart' as http;

class AgoraService {
  Future<void> joinRoom(context, String uid) async {
    print('x');
    print(uid);
    print(BigInt.parse(uid));

    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    // Call API for Agora token
    final channelName = getRandomString(10);
    final agoraToken = await _getAgoraToken(channelName);

    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: channelName,
          role: ClientRole.Broadcaster,
          token: agoraToken,
          uid: int.parse(uid.substring(0, 10)),
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<String> _getAgoraToken(String channelName) async {
    try {
      http.Response resp = await http
          .get(Uri.https(API_URL, 'token', {'channel_name': channelName}));
      // print(resp.statusCode);
      // print(resp.body);

      return resp.body;
    } catch (e) {
      return null;
    }
  }
}
