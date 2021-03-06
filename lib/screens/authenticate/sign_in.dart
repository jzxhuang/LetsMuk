import 'package:letsmuk/services/auth.dart';
import 'package:letsmuk/shared/constants.dart';
import 'package:letsmuk/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService auth = AuthService();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    // Google sign in
                    ElevatedButton(
                        child: Text(
                          'Sign In With Google',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() => loading = true);
                          dynamic result = await auth.signInWithGoogle();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          }
                        }),
                  ],
                )),
          );
  }
}
