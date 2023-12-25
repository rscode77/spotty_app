import 'package:flutter/material.dart';
import 'package:spotty_app/injector.dart';
import 'package:spotty_app/spotty_app.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  Injector();
  runApp(const SpottyApp());
}
