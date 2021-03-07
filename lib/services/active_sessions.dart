import 'dart:async';
import 'dart:convert';
import 'package:letsmuk/models/agora_channel.dart';
import 'package:letsmuk/shared/constants.dart';

import 'package:http/http.dart' as http;

class ActiveSessionService {
  Future<void> getActiveSessions() async {
    final response = await http.get(Uri.https(API_URL, 'active_channels'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('adslkfj');
      print(response.body);
      // TODO: fix this JSON decoding, need to decode it as a list of AgoraChannel (not just a single one)
      print(AgoraChannel.fromJson(jsonDecode(response.body)));
      return AgoraChannel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
