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
        return macos;
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
    apiKey: 'AIzaSyBRqTBisWvUIs4NP9pdvR0SBkteh4qdD6c',
    appId: '1:928560671910:web:db53e052acab6ea6f41867',
    messagingSenderId: '928560671910',
    projectId: 'hometasks-f823d',
    authDomain: 'hometasks-f823d.firebaseapp.com',
    storageBucket: 'hometasks-f823d.appspot.com',
    measurementId: 'G-2BDNXDHM2G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlRE5yd5WtMI0whmv48JQf-073bL3WcVs',
    appId: '1:928560671910:android:39fcaadb92497759f41867',
    messagingSenderId: '928560671910',
    projectId: 'hometasks-f823d',
    storageBucket: 'hometasks-f823d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAayxSpZJYp4QxSGzmVCq0aQ_obw7gtkuc',
    appId: '1:928560671910:ios:27e2c26714715228f41867',
    messagingSenderId: '928560671910',
    projectId: 'hometasks-f823d',
    storageBucket: 'hometasks-f823d.appspot.com',
    iosBundleId: 'com.example.homeAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAayxSpZJYp4QxSGzmVCq0aQ_obw7gtkuc',
    appId: '1:928560671910:ios:af6b7041e615c00af41867',
    messagingSenderId: '928560671910',
    projectId: 'hometasks-f823d',
    storageBucket: 'hometasks-f823d.appspot.com',
    iosBundleId: 'com.example.homeAssignment.RunnerTests',
  );
}
