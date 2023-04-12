import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          centerTitle: true,
          automaticallyImplyLeading: false,

          title: Text('Home page', style: GoogleFonts.manrope(
            letterSpacing: 3,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
            fontSize: 16,
          ),
          ),

          backgroundColor: Colors.grey.shade400,
          elevation: 5.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black87,),
              label: Text('Logout', style: GoogleFonts.manrope(
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 15,
              ),),
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
