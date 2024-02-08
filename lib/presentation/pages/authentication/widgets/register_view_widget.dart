import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/presentation/bloc/register_bloc.dart';
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

class RegisterViewWidget extends StatefulWidget {
  final Function(RegisterUserRequest)? onRegisterPressed;

  const RegisterViewWidget({
    super.key,
    required this.onRegisterPressed,
  });

  @override
  State<RegisterViewWidget> createState() => _RegisterViewWidgetState();
}

ExtendedTextEditingController _usernameController = ExtendedTextEditingController();
ExtendedTextEditingController _passwordController = ExtendedTextEditingController();
ExtendedTextEditingController _emailController = ExtendedTextEditingController();

class _RegisterViewWidgetState extends State<RegisterViewWidget> {
  bool get isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _usernameController.clear();
    _passwordController.clear();
    _emailController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: _registerListener,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _registerMessage(),
          _buildUsernameTextField(),
          const Space.vertical(16.0),
          _buildPasswordTextField(),
          const Space.vertical(16.0),
          _buildEmailTextField(),
          const Space.vertical(24.0),
          _buildRegisterButton(),
          const Space.vertical(24.0),
          _buildBackButton(),
        ],
      ),
    );
  }

  void _registerListener(BuildContext context, RegisterState state) {
    if (state is RegisterResultState) {
      if (!state.isSuccess) {
        if (state.field.isNotEmpty) {
          if (state.field == FieldsEnum.Username.value) {
            _usernameController.setErrorText(state.message);
          }
          if (state.field == FieldsEnum.Password.value) {
            _passwordController.setErrorText(state.message);
          }
          if (state.field == FieldsEnum.Email.value) {
            _emailController.setErrorText(state.message);
          }
        } else {
          CustomSnackbarWidget.showSnackbar(
            context: context,
            message: state.message,
          );
        }
      }
      if (state.isSuccess) {
        Navigator.pop(context);
      }
    }
  }

  Widget _registerMessage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).joinToSpotty,
            style: AppTextStyles.textTitle(
              color: isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
            ),
          ),
          const Space.vertical(8.0),
          Text(
            S.of(context).registerMessage,
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

  Widget _buildEmailTextField() {
    return AppTextField(
      field: FieldsEnum.Email,
      hint: S.of(context).email,
      controller: _emailController,
      isDarkTheme: isDarkTheme,
    );
  }

  Widget _buildRegisterButton() {
    return AppButton(
      buttonColor: AppColors.blue,
      onPressed: () => widget.onRegisterPressed?.call(
        RegisterUserRequest(
          username: _usernameController.text,
          password: _passwordController.text,
          email: _emailController.text,
        ),
      ),
      buttonText: S.of(context).register,
    );
  }

  Widget _buildBackButton() {
    return AppTextButton(
      buttonColor: AppColors.blue,
      onPressed: () => Navigator.pop(context),
      buttonText: S.of(context).back,
    );
  }
}
