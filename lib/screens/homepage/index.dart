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
  {
    "name": "jeff",
    "uid": "112150203641622258272",
  },
  {
    "name": "Alice",
    "uid": "111376690246824336476",
  },
  {
    "name": "Hyunzee",
    "uid": "110594606043658856673",
  }
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
      "start": "12:00",
      "end": "12:40",
    },
    {
      "name": "Alice",
      "start": "11:00",
      "end": "12:40",
    },
    {
      "name": "Jeff",
      "start": "12:20",
      "end": "12:50",
    },
    {
      "name": "Noor",
      "start": "12:00",
      "end": "12:40",
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
    initialize();
    activeChannels = _activeSessionService.getActiveSessions();
  }

  void initialize() async {
    for (var item in happeningNow) {
      final response = await fetchFriendPic(item['uid']);
      Map<String, dynamic> responseJson = json.decode(response.body);
      item['photoURL'] = responseJson['photos'][0]['url'];
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                height: 550,
                child: ListView(
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(13, 10, 10, 40),
                              child: Text(
                                "Hi ${widget.user.displayName.split(" ")[0]}!",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(13, 10, 10, 10),
                              child: Text(
                            'Who are you eating lunch with today?',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),),
                          Padding(
                              padding: EdgeInsets.fromLTRB(13, 10, 10, 40),
                              child: GestureDetector(
                                  onTap: () {
                                    (widget.name == "Add my lunch room"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Schedule(
                                                    user: widget.user)),
                                          )
                                        : widget._agora.joinRoom(context,
                                            widget.user.providerData[0].uid));
                                  },
                                  child: Card(
                                    color: Color.fromRGBO(237, 230, 219, 1),
                                    margin: EdgeInsets.fromLTRB(5, 10, 20, 10),
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding (
                                      padding: EdgeInsets.fromLTRB(7, 13, 13, 13),
                                      child: ListTile(
                                      leading: Icon(Icons.add),
                                      title: Text(widget.name),
                                      subtitle: Text(
                                          'Invite friends or have it open for others to join you!',
                                          style: TextStyle(
                                            fontSize: 12),
                                          ),
                                    ),),
                                  )))
                        ]),
                    GestureDetector(
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 50, 10),
                              child: Text(
                                'Hop into a room happening right now',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                            children: <Widget>[
                              for (var item in happeningNow)
                                  Container(
                                    width: 100,
                                    height: 150,
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      color: Color.fromRGBO(254, 232, 166, 1),
                                      shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding (
                                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                        child: ListTile(
                                        //leading: Icon(Icons.chat_bubble),
                                        title: Padding (
                                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                                          child: CircleAvatar(
                                            backgroundColor: Color.fromRGBO(254, 232, 166, 1),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              // width: 99,
                                              // height: 99,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(item['photoURL']))
                                              ),
                                            ),
                                          )),
                                        subtitle: Text('Munch with ${item['name']}',
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                            style: TextStyle(fontSize: 10),),
                                      ))))
                                      // child: Column(
                                      //   children: <Widget> [CircleAvatar(
                                      //     backgroundColor: Color.fromRGBO(254, 232, 166, 1),
                                      //     child: Container(
                                      //       margin: const EdgeInsets.symmetric( horizontal: 10),
                                      //       width: 60,
                                      //       height: 60,
                                      //       decoration: BoxDecoration(
                                      //         shape: BoxShape.circle,
                                      //         image: DecorationImage(
                                      //             image:
                                      //                 NetworkImage(item['photoURL']))
                                      //       ),
                                      //     ),
                                      //   )])))
                            ])
                          )
                        ],
                      ),
                      onTap: () {
                        widget._agora
                            .joinRoom(context, widget.user.providerData[0].uid);
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 60, 50, 10),
                              child: Text(
                                'See who else you can join soon',
                                //textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )),
                          for (var item in widget.friends)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Card(
                                  color: Color.fromRGBO(237, 230, 219, 1),
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ), child: Padding (
                                      padding: EdgeInsets.fromLTRB(0,5,5,5),
                                  child: ListTile(
                                    leading: Icon(Icons.chat_bubble),
                                    title: Text(
                                          "${item['start']} - Lunch with ${item['name']}",),
                                    subtitle: Text('Click to join your call',
                                      style: TextStyle(
                                            fontSize: 12),
                                          ),
                                  )),
                            ))
                        ],
                      ),
                      onTap: () {
                        widget._agora
                            .joinRoom(context, widget.user.providerData[0].uid);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                      child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.brown,
                            ),
                            onPressed: () {
                              widget._agora.joinRoom(
                                  context, widget.user.providerData[0].uid);
                            },
                            child: Text("Let's Eat"),
                        )),
                      ],
                    ))
                  ],
                ),
              ),
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
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        },
      ),
    );
  }
}
