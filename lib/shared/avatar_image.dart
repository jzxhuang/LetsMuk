import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  AvatarImage({Key key, this.imageUrl, this.width = 100, this.height = 100})
      : super(key: key);

  final String imageUrl;
  final double width;
  final double height;

  // This widget is the root of your application.

  // Create the initialization Future outside of `build`:
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.yellow, width: 1.5),
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                    imageUrl.replaceFirst("s96-c", "s240-c")))));
  }
}
