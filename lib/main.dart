import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spotty_app/firebase_options.dart';
import 'package:spotty_app/injector.dart';
import 'package:spotty_app/spotty_app.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injector();
  runApp(const SpottyApp());
}