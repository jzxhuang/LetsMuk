import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  AvatarImage({Key key, this.imageUrl}) : super(key: key);

  final String imageUrl;
  // This widget is the root of your application.

  // Create the initialization Future outside of `build`:
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.yellow, width: 2.0),
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                    imageUrl.replaceFirst("s96-c", "s240-c")))));
  }
}
