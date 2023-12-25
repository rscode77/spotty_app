part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  bool get isUserLocationEnabled => isLocationEnabled ?? false;

  final User? user;
  final bool? isLocationEnabled;
  final MapController mapController;

  const HomeState({
    this.user,
    this.isLocationEnabled,
    required this.mapController,
  });

  @override
  List<Object?> get props => [
        user,
        isLocationEnabled,
        mapController,
      ];

  HomeState copyWith({
    User? user,
    bool? isLocationEnabled,
    MapController? mapController,
  }) {
    return HomeLoading(
      user: user ?? this.user,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      mapController: mapController ?? this.mapController,
    );
  }
}

class HomeLoading extends HomeState {
  HomeLoading({
    User? user,
    bool? isLocationEnabled,
    MapController? mapController,
  }) : super(
          user: user,
          isLocationEnabled: isLocationEnabled,
          mapController: mapController ?? MapController(),
        );

  @override
  HomeState copyWith({
    User? user,
    bool? isLocationEnabled,
    MapController? mapController,
  }) {
    return HomeLoading(
      user: user ?? this.user,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      mapController: mapController ?? this.mapController,
    );
  }
}

class HomeLoaded extends HomeState {
  HomeLoaded({
    User? user,
    bool? isLocationEnabled,
    MapController? mapController,
  }) : super(
          user: user,
          isLocationEnabled: isLocationEnabled,
          mapController: mapController ?? MapController(),
        );

  @override
  HomeState copyWith({
    User? user,
    bool? isLocationEnabled,
    MapController? mapController,
  }) {
    return HomeLoaded(
      user: user ?? this.user,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      mapController: mapController ?? this.mapController,
    );
  }
}
