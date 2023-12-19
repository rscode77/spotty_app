import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/presentation/widgets/login_view_widget.dart';
import 'package:spotty_app/routing/route_constants.dart';
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
        context.go(RouteConstants.home);
      }
      if (state.field.isNotEmpty) {}
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
      onRegisterPressed: () => context.pushNamed(RouteConstants.register),
    );
  }
}
