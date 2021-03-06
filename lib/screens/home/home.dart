import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:letsmuk/screens/homepage/index.dart';

import 'package:letsmuk/services/auth.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title, this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final User user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Home object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // elevation: 0.0,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: Text('Logout'),
            onPressed: () async {
              await auth.signOut();
            },
          ),
        ],
      ),
      body: HomePage(user: widget.user),
    );
  }
}
