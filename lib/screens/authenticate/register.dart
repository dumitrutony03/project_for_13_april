import 'package:flutter/material.dart';
import 'package:project_for_13_april/screens/authenticate/sign_in.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import '../home/home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
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
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign up'),
              actions: <Widget>[
                TextButton.icon(
                    icon: const Icon(Icons.person),
                    label: const Text('Sign In'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                      //widget.toggleView(),
                    }),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 12.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          (val!.isEmpty) || (val.trim().length < 6)
                              ? 'Enter an email'
                              : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) =>
                          (val!.length < 6) || (val.trim().length < 6)
                              ? 'Enter a password 6+ chars long'
                              : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.pink[400],
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          // if the user has interracted with this form and button
                          if (_formKey.currentState?.validate() != null) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                            print('AM INTRODUS IN BAZA DE DATE');

                            if (result == null) {

                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            } else {
                              print('NU E NUUUUUUUUUUUL');

                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                                loading = false;
                              });
                            }
                          }
                        }),
                    const SizedBox(height: 10.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
