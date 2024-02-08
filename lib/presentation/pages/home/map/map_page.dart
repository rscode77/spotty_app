import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/presentation/bloc/home_bloc.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/presentation/pages/home/widgets/map_button.dart';
import 'package:spotty_app/presentation/pages/home/widgets/map_widget.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/enums/navigation_bar_items_enum.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final HomeBloc _homeBloc;

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  initState() {
    _homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(HomeState state) {
    if (state is HomeLoading) {
      return _buildLoading();
    }
    return Stack(
      children: [
        MapWidget(
          markers: state.markers ?? const {},
          mapController: (GoogleMapController mapController) {
            _homeBloc.mapController ??= mapController;
          },
        ),
        _buildMapButtons(),
      ],
    );
  }

  Widget _buildMapButtons() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildProfileAvatar(),
            const Space.vertical(10.0),
            _buildCenterButton(),
            const Space.vertical(10.0),
            _buildLocationButton(),
            const Space.vertical(10.0),
            _buildSearchButton(),
            const Space.vertical(16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routing.profilePage,
      ),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: _isDarkTheme ? Colors.black : Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
          color: _isDarkTheme ? DarkAppColors.mapAvatarButton : LightAppColors.mapAvatarButton,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/profile_avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return MapButton(
          onPressed: () => _homeBloc.add(const SetUserLocationStatusEvent()),
          isActive: state.isLocationEnabled ?? false,
          isDarkTheme: _isDarkTheme,
          icon: LucideIcons.radio,
        );
      },
    );
  }

  Widget _buildCenterButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return MapButton(
          onPressed: () => _homeBloc.add(const CenterMapOnUserLocationEvent()),
          isActive: state.isLocationCentered ?? false,
          isDarkTheme: _isDarkTheme,
          icon: LucideIcons.locate,
        );
      },
    );
  }

  Widget _buildSearchButton() {
    return MapButton(
      onPressed: () => _homeBloc.add(
        const UpdateNavigationBarItemEvent(navigationBarItem: NavigationBarItem.mapSearch),
      ),
      isDarkTheme: _isDarkTheme,
      isActive: false,
      icon: LucideIcons.search,
    );
  }

  Widget _buildLoading() {
    return const LoadingWidget(
      size: 40.0,
      strokeWidth: 3.0,
    );
  }
}
