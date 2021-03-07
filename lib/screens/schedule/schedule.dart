import 'package:letsmuk/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:letsmuk/screens/homepage/index.dart';
import 'package:letsmuk/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Schedule extends StatefulWidget {
    Schedule({Key key, this.user}) : super(key: key);

    final User user;

    @override
    _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
    TextEditingController nameController = new TextEditingController();

    bool first_enabled = false;
    bool second_enabled = false;
    bool third_enabled = false;
    bool fourth_enabled = false;

    Widget _title() {
        return Container(
            child: Text(
                'Host My Lunch Room',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                )
            ),
        );
    }

    Widget _roomName() {
        return Container(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 60),
            child: Material(
                child: TextField(
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name of my lunch room',
                ),
            ),
            ),
        );
    }

    Widget _invitations() {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
                height: 400.0,
                child: GridView.count(
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 37),
                                child: Text(
                                    'FRIENDS',
                                    style: TextStyle(
                                        color: (first_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3)
                                    ),
                                    border: Border.all(
                                        color: (first_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        )
                                    ),
                                    image: DecorationImage(
                                        image:AssetImage('assets/images/friends.png'), 
                                        fit:BoxFit.cover
                                    ),
                                )
                            ),onTap:(){
                                setState(() {
                                    first_enabled = true;
                                });
                            },
                        ),
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                    'BRING FRIENDS',
                                    style: TextStyle(
                                        color: (second_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3)
                                    ),
                                    border: Border.all(
                                        color: (second_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        )
                                    ),
                                    image: DecorationImage(
                                        image:AssetImage('assets/images/bring_friends.png'), 
                                        fit:BoxFit.cover
                                    ),
                                )
                            ),onTap:(){
                                setState(() {
                                    second_enabled = true;
                                });
                            }
                        ),
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 38),
                                child: Text(
                                    'PUBLIC',
                                    style: TextStyle(
                                        color: (third_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3)
                                    ),
                                    border: Border.all(
                                        color: (third_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        )
                                    ),
                                    image: DecorationImage(
                                        image:AssetImage('assets/images/public.png'), 
                                        fit:BoxFit.cover
                                    ),
                                )
                            ),onTap:(){
                                setState(() {
                                    third_enabled = true;
                                });
                            }
                        ),
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                child: Text(
                                    'INVITE ONLY',
                                    style: TextStyle(
                                        color: (fourth_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3)
                                    ),
                                    border: Border.all(
                                        color: (fourth_enabled
                                            ? Colors.blue
                                            : Colors.grey
                                        )
                                    ),
                                    image: DecorationImage(
                                        image:AssetImage('assets/images/invite_only.png'), 
                                        fit:BoxFit.cover
                                    ),
                                )
                            ),onTap:(){
                                setState(() {
                                    fourth_enabled = true;
                                });
                            }
                        ),
                    ],
                )
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: ListView(
                children: <Widget>[
                    _title(),
                    _roomName(),
                    Text(
                        'This is for...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                        )
                    ),
                    _invitations(),
                    ButtonBar(
                        children: <Widget>[
                            FlatButton(
                                minWidth: 150,
                                child: Text('CANCEL'),
                                color: Colors.white,
                                onPressed: () {
                                    Navigator.pop(context);
                                },
                            ),
                            FlatButton(
                                minWidth: 150,
                                child: Text('CREATE'),
                                color: Colors.blue,
                                onPressed: () {
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
                                    );
                                },
                            )
                        ]
                    )
                ]
            )
            ),
        );
    }
}