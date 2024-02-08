import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/login_view_widget.dart';
import 'package:spotty_app/routing/routing.dart';
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
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(
                AppDimensions.defaultPagePadding,
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
      return _buildLoading();
    }
    return _buildLoginView();
  }

  Widget _buildLoading() {
    return const CircularProgressIndicator();
  }

  Widget _buildLoginView() {
    return LoginViewWidget(
      onRegisterPressed: () => Navigator.pushNamed(
        context,
        Routing.register,
      ),
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
