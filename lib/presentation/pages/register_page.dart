import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotty_app/presentation/bloc/register/register_bloc.dart';
import 'package:spotty_app/presentation/widgets/register_view_widget.dart';
import 'package:spotty_app/common/widgets/custom_snackbar_widget.dart';
import 'package:spotty_app/common/widgets/loading_widget.dart';
import 'package:spotty_app/routing/route_constants.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: _registerListener,
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

  void _registerListener(
    BuildContext context,
    RegisterState state,
  ) {
    if (state is RegisterResultState) {
      if (state.isSuccess) {
        CustomSnackbarWidget.showSnackbar(
          context: context,
          message: state.message,
        );
        context.go(RouteConstants.registerConfirmation);
      }
    }
  }

  Widget _buildBody(RegisterState state) {
    if (state is RegisterLoading) {
      return const LoadingWidget();
    }
    return RegisterViewWidget(
      onRegisterPressed: (user) => context.read<RegisterBloc>().add(
            RegisterUserEvent(
              username: user.username,
              password: user.password,
              email: user.email,
            ),
          ),
    );
  }
}
