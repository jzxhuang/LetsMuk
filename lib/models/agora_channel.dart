class AgoraChannel {
  final String channelName;
  final List<String> uid;

  AgoraChannel({this.channelName, this.uid});
  factory AgoraChannel.fromJson(Map<String, dynamic> json) {
    return AgoraChannel(
      channelName: json['channel_name'],
      uid: json['users']['broadcasters'],
    );
  }
}
