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

    String type = "";

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
                    fontWeight: FontWeight.w900,
                    fontSize: 29,
                    fontFamily: 'Poppins'
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SizedBox(
                height: 400.0,
                child: GridView.count(
                    primary: false,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: <Widget>[
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                    'FRIENDS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (first_enabled
                                            ? Colors.brown
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: "Poppins"
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)
                                    ),
                                    border: Border.all(
                                        color: (first_enabled
                                            ? Colors.brown
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
                                    type = "For friends";
                                });
                            },
                        ),
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                    'BRING FRIENDS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (second_enabled
                                            ? Colors.brown
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: "Poppins"
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)
                                    ),
                                    border: Border.all(
                                        color: (second_enabled
                                            ? Colors.brown
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
                                    type = "For bring friends";
                                });
                            }
                        ),
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: Text(
                                    'PUBLIC',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (third_enabled
                                            ? Colors.brown
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: "Poppins"
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)
                                    ),
                                    border: Border.all(
                                        color: (third_enabled
                                            ? Colors.brown
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
                                    type = "For public";
                                });
                            }
                        ),
                        GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 22),
                                child: Text(
                                    'INVITE ONLY',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (fourth_enabled
                                            ? Colors.brown
                                            : Colors.grey
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: "Poppins"
                                    )
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)
                                    ),
                                    border: Border.all(
                                        color: (fourth_enabled
                                            ? Colors.brown
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
                                    type = "For invite only";
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
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: ListView(
                children: <Widget>[
                    _title(),
                    _roomName(),
                    Text(
                        'This is for...',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: "Poppins"
                        )
                    ),
                    _invitations(),
                    ButtonBar(
                        children: <Widget>[
                            FlatButton(
                                minWidth: 150,
                                child: Text('CANCEL',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.brown)),
                                color: Colors.white,
                                onPressed: () {
                                    Navigator.pop(context);
                                },
                            ),
                            FlatButton(
                                minWidth: 150,
                                child: Text('CREATE'),
                                color: Colors.brown,
                                onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomePage(name: nameController.text, type: type, user: widget.user)),
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
