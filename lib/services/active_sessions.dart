import 'dart:async';
import 'dart:convert';
import 'package:letsmuk/models/agora_channel.dart';
import 'package:letsmuk/shared/constants.dart';

import 'package:http/http.dart' as http;

class ActiveSessionService {
  Future<List<AgoraChannel>> getActiveSessions() async {
    final response = await http.get(Uri.https(API_URL, 'active_channels'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var arr = json.decode(response.body) as List;

      // for every element of arr map to _fromJson
      // and convert the array to list
      final res = arr.map((e) => AgoraChannel.fromJson(e)).toList();
      print(res);
      return res;

      // final parsedResponse =
      //     AgoraChannelList.fromJson(jsonDecode(response.body));
      // print(parsedResponse);
      // return parsedResponse;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
