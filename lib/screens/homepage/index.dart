// https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/models/agora_channel.dart';
import 'package:letsmuk/services/active_sessions.dart';
import 'package:letsmuk/services/agora.dart';
import 'package:letsmuk/screens/schedule/schedule.dart';

Future<http.Response> fetchFriendPic(String uid) async {
  return await http
      .get(Uri.https('content-people.googleapis.com', '/v1/people/' + uid, {
    "personFields": "photos",
    "sources": "READ_SOURCE_TYPE_PROFILE",
    "key": "AIzaSyAMoW3IMJ6qnc1ZRSswEZMryM8TdvJMbNI"
  }));
}

var happeningNow = [
  AgoraChannel(
    channelName: 'jeff_channel',
    users: ["112150203641622258272"],
  ),
  AgoraChannel(
    channelName: 'alice_channel',
    users: ["111376690246824336476"],
  ),
  AgoraChannel(
    channelName: 'hyunzee_channel',
    users: ["110594606043658856673"],
  ),

  // {
  //   "name": "Jeff",
  //   "uid": "112150203641622258272",
  // },
  // {
  //   "name": "Alice",
  //   "uid": "111376690246824336476",
  // },
  // {
  //   "name": "Hyunzee",
  //   "uid": "110594606043658856673",
  // }
];

class HomePage extends StatefulWidget {
  HomePage({Key key, this.name, this.type, this.user}) : super(key: key);

  final AgoraService _agora = AgoraService();

  final String name;
  final User user;
  final String type;
  final friends = [
    {
      "name": "Hyunzee",
      "start": "3:00",
      "end": "3:40",
      "description": "Late lunch!"
    },
    {
      "name": "Alice",
      "start": "7:00",
      "end": "7:40",
      "description": "Pad thai and chill"
    },
    {
      "name": "Joe",
      "start": "8:00",
      "end": "8:40",
      "description": "Raptors game tn"
    }
  ];

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<HomePage> {
  final ActiveSessionService _activeSessionService = new ActiveSessionService();

  Future<List<AgoraChannel>> activeChannels;
  // Future<String> activeChannels = Future<String>.delayed(
  //   Duration(seconds: 2),
  //   () => 'Data Loaded',
  // );

  @override
  void initState() {
    super.initState();
    activeChannels = _activeSessionService.getActiveSessions();
    // new Timer.periodic(
    //     Duration(seconds: 10),
    //     (Timer t) =>
    //         activeChannels = _activeSessionService.getActiveSessions());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: FutureBuilder<List<AgoraChannel>>(
        future: activeChannels, // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<AgoraChannel>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            print('has data');
            print(snapshot.data);
            snapshot.data.forEach((element) {
              print(element.channelName);
              print(element.users[0]);
            });

            children = <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: ListView(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                              child: Text(
                                "Hi ${widget.user.displayName.split(" ")[0]}!",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              'Chow down with a friend',
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.clip,
                              // softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Row(children: <Widget>[
                            for (var el in snapshot.data)
                              ActiveRoomIcon(
                                  agoraChannel: el, user: widget.user)

                            // for (var item in happeningNow)
                            //   ActiveRoomIcon(item: item)
                          ]),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Schedule(user: widget.user)),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.brown,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(7, 13, 13, 13),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              Color.fromRGBO(254, 232, 166, 1),
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            // width: 99,
                                            // height: 99,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/burrito_bear.png'))),
                                          ),
                                        ),
                                        title: Text(widget.name,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        subtitle: Text(
                                          'Invite friends or have it open for others to join you!',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ]),
                    GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                "Don't forget...",
                                //textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                          for (var item in widget.friends)
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                child: Card(
                                  color: Color.fromRGBO(237, 230, 219, 1),
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                      child: ListTile(
                                        leading: Icon(Icons.chat_bubble),
                                        title: Text(
                                          "${item['start']} PM",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          "${item['name']} — ${item['description']}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )),
                                ))
                        ],
                      ),
                      onTap: () {
                        widget._agora.joinRoom(
                          context,
                          widget.user.providerData[0].uid,
                        );
                      },
                    ),
                  ],
                ),
              )),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              Expanded(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading...'),
                    )
                  ])))
            ];
          }
          return Column(
            children: children,
          );
        },
      ),
    );
  }
}

class ActiveRoomIcon extends StatefulWidget {
  ActiveRoomIcon({Key key, this.agoraChannel, this.user}) : super(key: key);
  final AgoraChannel agoraChannel;

  final AgoraService _agora = AgoraService();
  final User user;

  @override
  State<StatefulWidget> createState() => ActiveRoomIconState();
}

class ActiveRoomIconState extends State<ActiveRoomIcon> {
  Future<http.Response> photoURLResp;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    photoURLResp = fetchFriendPic(widget.agoraChannel.users[0]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: photoURLResp, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          Widget toRender;
          if (snapshot.hasData) {
            Map<String, dynamic> responseJson = json.decode(snapshot.data.body);
            print(responseJson);
            String photoUrl = responseJson['photos'][0]['url'];

            toRender = Container(
                width: 110,
                // height: 150,
                child: Column(children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(254, 232, 166, 1),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        // width: 99,
                        // height: 99,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image:
                                DecorationImage(image: NetworkImage(photoUrl))),
                      ),
                    ),
                    onTap: () {
                      widget._agora.joinRoom(
                          context,
                          widget.user.providerData[0].uid,
                          widget.agoraChannel.channelName);
                    },
                  ),
                  // Padding(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  //     child: Text(
                  //       '${widget.item['name']}',
                  //       textAlign: TextAlign.center,
                  //       overflow: TextOverflow.clip,
                  //       softWrap: true,
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 10),
                  //     )),
                ]));
          } else if (snapshot.hasError) {
            toRender = Column(children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ]);
          } else {
            toRender = Text('...');
          }
          return toRender;
        });
  }
}
