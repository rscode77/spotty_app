import 'package:flutter/material.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';

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
                buttonColor: AppColors.black,
                onPressed: () => Navigator.pop(context),
                buttonText: 'Powrót do logowania',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
