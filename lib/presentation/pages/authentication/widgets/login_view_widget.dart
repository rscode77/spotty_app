import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_text_field.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/common/widgets/custom_snackbar_widget.dart';
import 'package:spotty_app/routing/route_constants.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';

class LoginViewWidget extends StatefulWidget {
  final Function()? onRegisterPressed;

  const LoginViewWidget({
    super.key,
    required this.onRegisterPressed,
  });

  @override
  State<LoginViewWidget> createState() => _LoginViewWidgetState();
}

class _LoginViewWidgetState extends State<LoginViewWidget> {
  final ExtendedTextEditingController _usernameController = ExtendedTextEditingController();
  final ExtendedTextEditingController _passwordController = ExtendedTextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _loginListener,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUsernameTextField(),
          _buildPasswordTextField(),
          _buildLoginButton(),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state is LoginResultState) {
      if (!state.isSuccess) {
        if (state.field.isNotEmpty) {
          if (state.field == FieldsEnum.Username.value) {
            _usernameController.setErrorText(state.message);
          }
          if (state.field == FieldsEnum.Password.value) {
            _passwordController.setErrorText(state.message);
          }
        }
        else{
          CustomSnackbarWidget.showSnackbar(
            context: context,
            message: state.message,
          );
        }
      }
      if(state.isSuccess){
        context.go(RouteConstants.home);
      }
    }
  }

  Widget _buildUsernameTextField() {
    return AppTextField(
      hint: S.of(context).username,
      controller: _usernameController,
    );
  }

  Widget _buildPasswordTextField() {
    return AppTextField(
      hint: S.of(context).password,
      controller: _passwordController,
    );
  }

  Widget _buildLoginButton() {
    return AppButton(
      onPressed: () => context.read<LoginBloc>().add(
            LoginUserEvent(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          ),
      buttonText: S.of(context).login,
    );
  }

  Widget _buildRegisterButton() {
    return AppButton(
      onPressed: widget.onRegisterPressed,
      buttonText: S.of(context).register,
    );
  }
}
