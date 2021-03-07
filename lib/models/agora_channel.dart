class AgoraChannel {
  final String channelName;
  // final List<String> uid;
  final List<String> users;

  AgoraChannel({this.channelName, this.users});

  factory AgoraChannel.fromJson(Map<String, dynamic> json) {
    var usersFromJson = json['users'];
    List<String> usersList = usersFromJson.cast<String>();

    return AgoraChannel(channelName: json['channel_name'], users: usersList
        // uid: json['users']['broadcasters'],
        );
  }
}

class AgoraChannelList {
  final List<AgoraChannel> channels;

  AgoraChannelList({
    this.channels,
  });

  factory AgoraChannelList.fromJson(List<dynamic> parsedJson) {
    List<AgoraChannel> channels = <AgoraChannel>[];
    channels = parsedJson.map((i) => AgoraChannel.fromJson(i)).toList();

    return new AgoraChannelList(channels: channels);
  }
}
