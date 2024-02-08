import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_text_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_text_field.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/common/widgets/custom_snackbar_widget.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class LoginViewWidget extends StatefulWidget {
  final Function() onRegisterPressed;
  final Function(String, String) onLoginPressed;

  const LoginViewWidget({
    super.key,
    required this.onRegisterPressed,
    required this.onLoginPressed,
  });

  @override
  State<LoginViewWidget> createState() => _LoginViewWidgetState();
}

class _LoginViewWidgetState extends State<LoginViewWidget> {
  final ExtendedTextEditingController _usernameController = ExtendedTextEditingController();
  final ExtendedTextEditingController _passwordController = ExtendedTextEditingController();

  bool get isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _loginListener,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          _welcomeMessage(),
          _buildUsernameTextField(),
          const Space.vertical(16.0),
          _buildPasswordTextField(),
          const Space.vertical(24.0),
          _buildLoginButton(),
          const Space.vertical(24.0),
          _buildForgotPasswordButton(),
          const Spacer(),
          _buildRegisterButton(),
          const Space.vertical(8.0),
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
      if (state.isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routing.mainPage,
          (route) => false,
        );
      }
    }
  }

  Widget _welcomeMessage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).hello,
            style: AppTextStyles.textTitle(
              color: isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
            ),
          ),
          const Space.vertical(8.0),
          Text(
            S.of(context).loginToYourAccount,
            style: AppTextStyles.textSubtitle(
              color: isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
            ),
          ),
          const Space.vertical(24.0),
        ],
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return AppTextField(
      field: FieldsEnum.Username,
      hint: S.of(context).username,
      controller: _usernameController,
      isDarkTheme: isDarkTheme,
    );
  }

  Widget _buildPasswordTextField() {
    return AppTextField(
      field: FieldsEnum.Password,
      hint: S.of(context).password,
      controller: _passwordController,
      isDarkTheme: isDarkTheme,
    );
  }

  Widget _buildLoginButton() {
    return AppButton(
      buttonColor: AppColors.blue,
      onPressed: () => widget.onLoginPressed(
        _usernameController.text,
        _passwordController.text,
      ),
      buttonText: S.of(context).login,
    );
  }

  Widget _buildForgotPasswordButton() {
    return AppTextButton(
      buttonColor: AppColors.blue,
      onPressed: widget.onRegisterPressed,
      buttonText: S.of(context).forgotPassword,
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).dontHaveAnAccount,
          style: AppTextStyles.textSubtitle(
            color: isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
          ),
        ),
        AppTextButton(
          buttonColor: AppColors.blue,
          onPressed: widget.onRegisterPressed,
          buttonText: S.of(context).register,
        ),
      ],
    );
  }
}
