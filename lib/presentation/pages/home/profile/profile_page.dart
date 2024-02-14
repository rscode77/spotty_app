import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/requests/add_vehicle_request.dart';
import 'package:spotty_app/data/models/user_model.dart';
import 'package:spotty_app/data/models/vehicle_model.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/presentation/bloc/profile_bloc.dart';
import 'package:spotty_app/presentation/bloc/vehicle_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/presentation/pages/home/profile/add_new_vehicle_dialog.dart';
import 'package:spotty_app/presentation/pages/home/profile/profile_avatar_widget.dart';
import 'package:spotty_app/presentation/pages/home/profile/vehicle_list_view_element.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final LoginBloc _loginBloc;
  late final ProfileBloc _profileBloc;
  late final VehicleBloc _vehicleBloc;

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    _profileBloc = context.read<ProfileBloc>();
    _vehicleBloc = context.read<VehicleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPagePadding,
          ),
          child: BlocListener<VehicleBloc, VehicleState>(
            listener: _vehicleBlocListener,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return _buildBody(state);
              },
            ),
          ),
        ),
      ),
    );
  }

  // TODO listening of add new vehicle status and show exceptions
  void _vehicleBlocListener(BuildContext context, VehicleState state) {}

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: Constants.centerAppBar,
      title: Text(
        S.of(context).profile,
        style: AppTextStyles.appBarTitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state is ProfileLoadingState) {
      return const LoadingWidget(
        size: 40.0,
        strokeWidth: 3.0,
      );
    }
    if (state is ProfileLoadedState) {
      return Column(
        children: [
          const SizedBox(height: 24.0),
          _buildProfile(state.user),
          const SizedBox(height: 44.0),
          _vehicleListHeader(),
          const SizedBox(height: 8.0),
          _vehiclesListView(
            vehicles: state.user.vehicles ?? [],
            defaultVehicleId: state.user.vehicle?.vehicleId ?? 0,
          ),
          _addNewVehicle(),
          const SizedBox(height: 8.0),
          _backButton(),
          const SizedBox(height: 24.0),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildProfile(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _profileAvatar(user.avatar),
        const SizedBox(height: 16.0),
        _buildProfileDetails(user),
      ],
    );
  }

  Widget _buildProfileDetails(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _username(user.username),
        _userEmail(user.email),
      ],
    );
  }

  Widget _username(String username) {
    return Column(
      children: [
        Text(
          username,
          style: AppTextStyles.title().copyWith(
            color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
            fontSize: 22.0,
          ),
        ),
      ],
    );
  }

  Widget _userEmail(String email) {
    return Text(
      email,
      style: AppTextStyles.eventInformation().copyWith(
        color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    );
  }

  Widget _vehicleListHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        S.of(context).yourVehicles,
        style: AppTextStyles.eventTitle().copyWith(
          fontSize: 14.0,
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
    );
  }

  Widget _vehiclesListView({
    required List<Vehicle> vehicles,
    required int defaultVehicleId,
  }) {
    return Expanded(
      child: vehicles.isEmpty
          ? _buildEmptyListMessage()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                Vehicle vehicleElement = vehicles[index];
                return VehicleListViewElement(
                  defaultVehicleId: defaultVehicleId,
                  vehicle: vehicleElement,
                  isDarkTheme: _isDarkTheme,
                  onRemoveVehicle: (int vehicleId) => _onRemoveVehicle(vehicleId),
                  onSetDefaultVehicle: (int vehicleId) => _onSetDefaultVehicle(vehicleId),
                );
              },
            ),
    );
  }

  void _onRemoveVehicle(int vehicleId) {
    _profileBloc.add(RemoveVehicleEvent(vehicleId: vehicleId));
  }

  void _onSetDefaultVehicle(int vehicleId) {
    _profileBloc.add(UpdateDefaultVehicleEvent(vehicleId: vehicleId));
  }

  Widget _buildEmptyListMessage() {
    return Center(
      child: Text(
        S.of(context).vehicleNotAdded,
        style: AppTextStyles.eventDescription().copyWith(
          color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
        ),
      ),
    );
  }

  Widget _profileAvatar(String avatar) {
    if (avatar.isEmpty) avatar = 'https://rscode.site/spotty/default_image.png';
    return ProfileAvatarImage(
      avatarUrl: avatar,
      isDarkTheme: _isDarkTheme,
    );
  }

  Widget _addNewVehicle() {
    return AppButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: _vehicleBloc,
          child: AddNewVehicleDialog(
            userId: _loginBloc.loggedInUserId,
            onVehicleSave: (AddVehicleRequest vehicle) => _onAddVehicle(vehicle),
          ),
        ),
      ),
      buttonText: S.of(context).addNewVehicle,
      buttonColor: AppColors.blue,
    );
  }

  Widget _backButton() {
    return AppButton(
      onPressed: () => Navigator.pop(context),
      buttonText: S.of(context).back,
      buttonColor: AppColors.lightBlue,
      buttonTextColor: AppColors.blue,
    );
  }

  void _onAddVehicle(AddVehicleRequest vehicle) {
    _vehicleBloc.add(AddNewVehicleEvent(vehicle: vehicle));
    Navigator.pop(context);
  }
}
