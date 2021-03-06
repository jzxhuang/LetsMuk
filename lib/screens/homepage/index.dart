// https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart

import 'package:flutter/material.dart';
import 'package:letsmuk/screens/videocall/index.dart';


class HomePage extends StatefulWidget {
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
          height: 400,
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container (
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Text(
                      'Hello, Welcome back!',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
                  Text(
                    'Who are you eating lunch with today?',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    style: TextStyle(fontSize:18),
                  ),]
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: GestureDetector(
                  onTap: () {
                },
                  child: Card(
                    child: const ListTile(
                        leading: Icon(Icons.add),
                        title: Text('Add my lunch room'),
                        subtitle: Text('Add your availability for this week!'),
                      ),)
                )
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                      Text(
                        'Who are you eating lunch with today?',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(fontSize:18),
                      ),
                   Card(
                      child: const ListTile(
                        leading: Icon(Icons.timer),
                        title: Text('11:30 - Lunch with Hyunzee and Jeff'),
                        subtitle: Text('Click to join your call'),
                      ))],
                ),
                onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoCallHome()),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}