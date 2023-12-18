import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/common/widgets/app_button.dart';
import 'package:spotty_app/common/widgets/app_text_field.dart';
import 'package:spotty_app/generated/l10n.dart';

class LoginViewWidget extends StatefulWidget {
  const LoginViewWidget({super.key});

  @override
  State<LoginViewWidget> createState() => _LoginViewWidgetState();
}

class _LoginViewWidgetState extends State<LoginViewWidget> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLoginTextField(),
        _buildPasswordTextField(),
        _buildLoginButton(),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildLoginTextField() {
    return AppTextField(
      hint: S.of(context).login,
      controller: _loginController,
    );
  }

  Widget _buildPasswordTextField() {
    return AppTextField(
      hint: S.of(context).login,
      controller: _passwordController,
    );
  }

  Widget _buildLoginButton() {
    return AppButton(
      onPressed: () => context.read<LoginBloc>().add(
            LoginUserEvent(
              username: _loginController.text,
              password: _passwordController.text,
            ),
          ),
      buttonText: S.of(context).login,
    );
  }

  Widget _buildRegisterButton() {
    return AppButton(
      onPressed: null,
      buttonText: S.of(context).register,
    );
  }
}
