import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/user_location_model.dart';
import 'package:spotty_app/presentation/bloc/home/home_bloc.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LoginBloc _loginBloc;

  @override
  initState() {
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                AppButton(
                  onPressed: () => UserLocation(
                    username: 'asd',
                    latitude: 123,
                    longitude: 123,
                    vehicleColor: 'dasd',
                    vehicleType: null,
                  ),
                  buttonText: 'Wyloguj',
                );
                return Text('asd');
              },
            )
          ],
        ),
      ),
    );
  }
}
