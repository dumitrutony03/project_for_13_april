// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBsCx-Az8Zd8bEZ4g-UVN5qLeXX9yPHv4E',
    appId: '1:728575997294:web:ad346f5f6e37f9b6237d7f',
    messagingSenderId: '728575997294',
    projectId: 'projectfor13april',
    authDomain: 'projectfor13april.firebaseapp.com',
    databaseURL: 'https://projectfor13april-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'projectfor13april.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzx4-D3VaMEr3fcY3d7zh7r2cVpMmE3v4',
    appId: '1:728575997294:android:de8660f7de2e0295237d7f',
    messagingSenderId: '728575997294',
    projectId: 'projectfor13april',
    databaseURL: 'https://projectfor13april-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'projectfor13april.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKnijOicnsYLrHskII_ILLQrjIuc5I9s4',
    appId: '1:728575997294:ios:ade8ed5578a63b08237d7f',
    messagingSenderId: '728575997294',
    projectId: 'projectfor13april',
    databaseURL: 'https://projectfor13april-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'projectfor13april.appspot.com',
    iosClientId: '728575997294-le5m8a05kfpam3a714qbdse1ai9iugb8.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectFor13April',
  );
}