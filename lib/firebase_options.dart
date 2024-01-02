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
    apiKey: 'AIzaSyA7ie6qL2qI0xwrMXspGtmITof8NwXr-Gk',
    appId: '1:739383443508:web:2d083472ba095266854a61',
    messagingSenderId: '739383443508',
    projectId: 'spotty-37292',
    authDomain: 'spotty-37292.firebaseapp.com',
    storageBucket: 'spotty-37292.appspot.com',
    measurementId: 'G-B5DSY10SR2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3oQd0xui7gNjs2x0VGlIiioP2X4L2xPc',
    appId: '1:739383443508:android:8c60bc60fc9d329e854a61',
    messagingSenderId: '739383443508',
    projectId: 'spotty-37292',
    storageBucket: 'spotty-37292.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-BQmNQ1XPfBqpsWmS7zOc-78Y-x5mjn0',
    appId: '1:739383443508:ios:ebb5d0aeece1453d854a61',
    messagingSenderId: '739383443508',
    projectId: 'spotty-37292',
    storageBucket: 'spotty-37292.appspot.com',
    iosBundleId: 'com.example.spottyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-BQmNQ1XPfBqpsWmS7zOc-78Y-x5mjn0',
    appId: '1:739383443508:ios:392a6127943fd1ff854a61',
    messagingSenderId: '739383443508',
    projectId: 'spotty-37292',
    storageBucket: 'spotty-37292.appspot.com',
    iosBundleId: 'com.example.spottyApp.RunnerTests',
  );
}