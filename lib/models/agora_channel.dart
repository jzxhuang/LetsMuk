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

class PhotosList {
  final List<Photo> photos;

  PhotosList({
    this.photos,
  });

  factory PhotosList.fromJson(List<dynamic> parsedJson) {
    List<Photo> photos = new List<Photo>();
    photos = parsedJson.map((i) => Photo.fromJson(i)).toList();

    return new PhotosList(photos: photos);
  }
}

class Photo {
  final String id;
  final String title;
  final String url;

  Photo({this.id, this.url, this.title});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo(
      id: json['id'].toString(),
      title: json['title'],
      url: json['json'],
    );
  }
}
