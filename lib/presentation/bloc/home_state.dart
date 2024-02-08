part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  bool get isUserLocationEnabled => isLocationEnabled ?? false;

  final User? user;
  final bool? isLocationEnabled;
  final bool? isLocationCentered;
  final NavigationBarItem currentTab;
  final Set<Marker>? markers;

  const HomeState({
    this.user,
    this.isLocationEnabled,
    this.isLocationCentered,
    this.markers,
    this.currentTab = NavigationBarItem.map,
  });

  @override
  List<Object?> get props => [
    user,
    isLocationEnabled,
    isLocationCentered,
    currentTab,
    markers,
  ];

  HomeState copyWith({
    User? user,
    bool? isLocationEnabled,
    bool? isLocationCentered,
    NavigationBarItem? currentTab,
    Set<Marker>? markers,
  }) {
    return HomeLoading(
      user: user ?? this.user,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      isLocationCentered: isLocationCentered ?? this.isLocationCentered,
      currentTab: currentTab ?? this.currentTab,
      markers: markers ?? this.markers,
    );
  }
}

class HomeLoading extends HomeState {
  const HomeLoading({
    User? user,
    bool? isLocationEnabled,
    bool? isLocationCentered,
    NavigationBarItem currentTab = NavigationBarItem.map,
    Set<Marker>? markers,
  }) : super(
    user: user,
    isLocationEnabled: isLocationEnabled,
    isLocationCentered: isLocationCentered,
    currentTab: currentTab,
    markers: markers,
  );

  @override
  HomeState copyWith({
    User? user,
    bool? isLocationEnabled,
    bool? isLocationCentered,
    NavigationBarItem? currentTab,
    Set<Marker>? markers,
  }) {
    return HomeLoading(
      user: user ?? this.user,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      isLocationCentered: isLocationCentered ?? this.isLocationCentered,
      currentTab: currentTab ?? this.currentTab,
      markers: markers ?? this.markers,
    );
  }
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    User? user,
    bool? isLocationEnabled,
    bool? isLocationCentered,
    NavigationBarItem? currentTab,
    Set<Marker>? markers,
  }) : super(
    user: user,
    isLocationEnabled: isLocationEnabled,
    isLocationCentered: isLocationCentered,
    currentTab: currentTab ?? NavigationBarItem.map,
    markers: markers,
  );

  @override
  HomeState copyWith({
    User? user,
    bool? isLocationEnabled,
    bool? isLocationCentered,
    NavigationBarItem? currentTab,
    Set<Marker>? markers,
  }) {
    return HomeLoaded(
      user: user ?? this.user,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      isLocationCentered: isLocationCentered ?? this.isLocationCentered,
      currentTab: currentTab ?? this.currentTab,
      markers: markers ?? this.markers,
    );
  }
}