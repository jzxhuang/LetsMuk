// https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/shared/avatar_image.dart';
import 'package:letsmuk/services/agora.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.user}) : super(key: key);

  final AgoraService _agora = AgoraService();

  final User user;

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: 600,
          child: Column(
            children: <Widget>[
              Column(children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Text(
                      "Hi ${widget.user.displayName.split(" ")[0]}!",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                AvatarImage(imageUrl: widget.user.photoURL),
                Text(
                  'Who are you eating lunch with today?',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: TextStyle(fontSize: 18),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'TODO: Show a list of active meetings you can join',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: const ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Add my lunch room'),
                          subtitle:
                              Text('Add your availability for this week!'),
                        ),
                      ))),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Who are you eating lunch with today?',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: TextStyle(fontSize: 18),
                    ),
                    Card(
                        child: const ListTile(
                      leading: Icon(Icons.timer),
                      title: Text('11:30 - Lunch with Hyunzee and Jeff'),
                      subtitle: Text('Click to join your call'),
                    ))
                  ],
                ),
                onTap: () {
                  widget._agora.joinRoom(context);
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      widget._agora.joinRoom(context);
                    },
                    child: Text('Start Call'),
                    // color: Colors.blueAccent,
                    // textColor: Colors.white,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
