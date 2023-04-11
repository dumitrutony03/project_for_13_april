import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_for_13_april/firebase_options.dart';
import 'package:project_for_13_april/screens/wrapper.dart';
import 'package:project_for_13_april/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'project_for_13_april',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().userStream,
      initialData: UserModel(uid: 'initialUid'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
