import 'package:flutter/material.dart';
import 'package:project_for_13_april/screens/authenticate/sign_in.dart';
import 'package:project_for_13_april/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../models/car.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import '../pages/input_cars_from_user.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return //MaterialApp(
        StreamProvider<List<Car>>.value(
      value: DatabaseService().cars, // ?
      initialData: [],

      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home page'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
            ),
          ],
        ),
        body: InputCarsFromUser(),
      ),
    );
    // );
  }
}
