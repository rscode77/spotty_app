import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spotty_app/firebase_options.dart';
import 'package:spotty_app/injector.dart';
import 'package:spotty_app/services/firebase_config_service.dart';
import 'package:spotty_app/spotty_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService().initialize();
  Injector();
  runApp(const SpottyApp());
}
