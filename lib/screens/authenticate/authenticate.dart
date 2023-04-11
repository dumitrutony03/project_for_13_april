import 'package:flutter/material.dart';
import 'package:project_for_13_april/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
/*
  bool showSignIn = true;
  void changeRegisterAuthenticate() {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }
*/

  @override
  Widget build(BuildContext context) {
    return Register();
    /*if (showSignIn) {
      return SignIn(toggleView: changeRegisterAuthenticate);
    } else {
      return Register(toggleView: changeRegisterAuthenticate);
    }*/
  }
}
