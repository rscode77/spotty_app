import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/routing/routing.dart';

class SpottyApp extends StatefulWidget {
  const SpottyApp({Key? key}) : super(key: key);

  @override
  State<SpottyApp> createState() => _SpottyAppState();
}

class _SpottyAppState extends State<SpottyApp> {
  final String initialRoute = Routing.login;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: Routing.getMainRoute,
      onGenerateTitle: (context) => S.of(context).login,
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        S.delegate,
      ],
    );
  }
}