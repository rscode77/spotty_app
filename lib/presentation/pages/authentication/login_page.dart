import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/presentation/bloc/home/chat_bloc.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/login_view_widget.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: _loginListener,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(
                AppDimensions.defaultPadding,
              ),
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state is LoginResultState) {
      if (state.isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routing.home,
          (route) => false,
        );
      }
      if (!state.isSuccess) {
        if (state.field.isNotEmpty) {}
      }
    }
  }

  Widget _buildBody(LoginState state) {
    if (state is LoginInitial) {
      return _buildLoading();
    }
    return _buildLoginView();
  }

  Widget _buildLoading() {
    return const CircularProgressIndicator();
  }

  Widget _buildLoginView() {
    return LoginViewWidget(
      onRegisterPressed: () => {},
      onLoginPressed: (username, password) => _onLoginPressed(
        username: username,
        password: password,
      ),
    );
  }

  void _onLoginPressed({
    required String username,
    required String password,
  }) {
    context.read<LoginBloc>().add(
          LoginUserEvent(
            username: username,
            password: password,
          ),
        );
  }
}
