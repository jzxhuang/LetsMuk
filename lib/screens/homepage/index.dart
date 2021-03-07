// https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/shared/avatar_image.dart';
import 'package:letsmuk/services/agora.dart';

Future<http.Response>  fetchFriendPic(String uid) async{
  return await http.get(Uri.https('content-people.googleapis.com', '/v1/people/' + uid,
    { "personFields" : "photos", "sources": "READ_SOURCE_TYPE_PROFILE", "key": "AIzaSyAMoW3IMJ6qnc1ZRSswEZMryM8TdvJMbNI" }));
}

var happeningNow = [{
    "name": "jeff",
    "uid": "112150203641622258272",
  },{
    "name": "Alice",
    "uid": "111376690246824336476",
  },
  {
    "name": "Hyunzee",
    "uid": "110594606043658856673",
  }];

class HomePage extends StatefulWidget {
  HomePage({Key key, this.user}) : super(key: key);

  final AgoraService _agora = AgoraService();

  final User user;
  final friends = [{
    "name": "Hyunzee",
    "start": "12:00",
    "end": "12:40",
  },{
    "name": "Alice",
    "start": "11:00",
    "end": "12:40",
  },{
    "name": "Jeff",
    "start": "12:20",
    "end": "12:50",
  },{
    "name": "Noor",
    "start": "12:00",
    "end": "12:40",
  }];
  
  


  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initialize();
  } 
  void initialize() async {
    print('hello');
        for(var item in happeningNow) {

         final response = await fetchFriendPic(item['uid']);
         Map<String, dynamic> responseJson = json.decode(response.body);
         item['photoURL'] = responseJson['photos'][0]['url'];
  }}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: 600,
          child: ListView(
            children: <Widget>[
              Column(children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Text(
                      "Hi ${widget.user.displayName.split(" ")[0]}!",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
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
                    Container(
                      child: Text(
                      'Hop into a lunch room happening now',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: TextStyle(fontSize: 14),
                    ),
                      ),
                    for(var item in happeningNow ) Container(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Chip(
                        backgroundColor: Color.fromRGBO(254,232,166,1),
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          
                          child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(item['photoURL']),
                            fit: BoxFit.fill
                          ),
                          ),
                        ),
                        ),
                        label: Text("Join ${item['name']}'s lunch room"),
                      ))
                  ],
                ),
                onTap: () {
                  widget._agora.joinRoom(context);
                },
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text(
                        'Who are you eating lunch with today?',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    for(var item in widget.friends ) Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                          child: ListTile(
                          leading: Icon(Icons.chat_bubble),
                          title: Text("${item['start']} - Lunch with ${item['name']}"),
                          subtitle: Text('Click to join your call'),
                      )),
                    )
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
