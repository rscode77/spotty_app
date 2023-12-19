import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotty_app/data/models/requests/register_user_request.dart';
import 'package:spotty_app/presentation/bloc/register/register_bloc.dart';
import 'package:spotty_app/common/widgets/app_button.dart';
import 'package:spotty_app/common/widgets/app_text_field.dart';
import 'package:spotty_app/common/widgets/custom_snackbar_widget.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/routing/route_constants.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';

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
          _buildUsernameTextField(),
          _buildPasswordTextField(),
          _buildEmailTextField(),
          _buildRegisterButton(),
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
        context.go(RouteConstants.registerConfirmation);
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

  Widget _buildEmailTextField() {
    return AppTextField(
      hint: S.of(context).email,
      controller: _emailController,
    );
  }

  Widget _buildRegisterButton() {
    return AppButton(
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
    return AppButton(
      onPressed: () => context.pop(),
      buttonText: S.of(context).back,
    );
  }
}
