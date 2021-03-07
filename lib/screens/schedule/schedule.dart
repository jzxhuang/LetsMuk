import 'package:letsmuk/services/agora.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Schedule extends StatefulWidget {
  Schedule({Key key, this.user}) : super(key: key);

  final User user;
  final AgoraService _agora = AgoraService();

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  TextEditingController nameController = new TextEditingController();

  String type = "";

  bool friendsEnabled = false;
  bool friendsOfFriendsEnabled = false;
  bool publicEnabled = false;
  bool inviteOnlyEnabled = false;

  @override
  void initState() {
    super.initState();

    // hack uid to shorter uid and put it in our "postgres hash map"
    nameController =
        new TextEditingController(text: "${widget.user.displayName}'s Room");
  }

  Widget _title() {
    return Container(
      child: Text("Time to Eat!",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 29,
              fontFamily: 'Poppins')),
    );
  }

  Widget _roomName() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 50),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      child: Text('FRIENDS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  (friendsEnabled ? Colors.brown : Colors.grey),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: "Poppins")),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color:
                                (friendsEnabled ? Colors.brown : Colors.grey)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/friends.png'),
                            fit: BoxFit.cover),
                      )),
                  onTap: () {
                    setState(() {
                      friendsEnabled = !friendsEnabled;
                      type = "For friends";
                    });
                  },
                ),
                GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('BRING FRIENDS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: (friendsOfFriendsEnabled
                                    ? Colors.brown
                                    : Colors.grey),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: "Poppins")),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: (friendsOfFriendsEnabled
                                  ? Colors.brown
                                  : Colors.grey)),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/bring_friends.png'),
                              fit: BoxFit.cover),
                        )),
                    onTap: () {
                      setState(() {
                        friendsOfFriendsEnabled = !friendsOfFriendsEnabled;
                        type = "For bring friends";
                      });
                    }),
                GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text('PUBLIC',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: (publicEnabled
                                    ? Colors.brown
                                    : Colors.grey),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: "Poppins")),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color:
                                  (publicEnabled ? Colors.brown : Colors.grey)),
                          image: DecorationImage(
                              image: AssetImage('assets/images/public.png'),
                              fit: BoxFit.cover),
                        )),
                    onTap: () {
                      setState(() {
                        publicEnabled = !publicEnabled;
                        type = "For public";
                      });
                    }),
                GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Text('INVITE ONLY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: (inviteOnlyEnabled
                                    ? Colors.brown
                                    : Colors.grey),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: "Poppins")),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: (inviteOnlyEnabled
                                  ? Colors.brown
                                  : Colors.grey)),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/invite_only.png'),
                              fit: BoxFit.cover),
                        )),
                    onTap: () {
                      setState(() {
                        inviteOnlyEnabled = !inviteOnlyEnabled;
                        type = "For invite only";
                      });
                    }),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: ListView(children: <Widget>[
            _title(),
            _roomName(),
            Text('This is for...',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontFamily: "Poppins")),
            _invitations(),
            ButtonBar(children: <Widget>[
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
                  widget._agora
                      .joinRoom(context, widget.user.providerData[0].uid);
                },
              )
            ])
          ])),
    );
  }
}
