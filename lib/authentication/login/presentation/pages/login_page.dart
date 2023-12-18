import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/authentication/login/presentation/widgets/login_view_widget.dart';
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
        child: BlocBuilder<LoginBloc, LoginState>(
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

  Widget _buildBody(LoginState state) {
    if (state is LoginInitial) {
      return _buildInitial();
    } else if (state is LoginInputState) {
      return _buildLoginView();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildInitial() {
    return Container();
  }

  Widget _buildLoginView() {
    return const LoginViewWidget();
  }
}
