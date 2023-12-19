import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotty_app/common/widgets/app_button.dart';
import 'package:spotty_app/routing/route_constants.dart';

class RegisterConfirmationPage extends StatefulWidget {
  const RegisterConfirmationPage({super.key});

  @override
  State<RegisterConfirmationPage> createState() => _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState extends State<RegisterConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              AppButton(
                onPressed: () => context.go(RouteConstants.login),
                buttonText: 'Powrót do logowania',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
