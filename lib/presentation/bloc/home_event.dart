part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class RefreshTokenEvent extends HomeEvent {
  const RefreshTokenEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentUserDataEvent extends HomeEvent {
  const GetCurrentUserDataEvent();

  @override
  List<Object?> get props => [];
}

class SetUserLocationStatusEvent extends HomeEvent {
  const SetUserLocationStatusEvent();

  @override
  List<Object?> get props => [];
}

class NavigationBarTabChanged extends HomeEvent {
  final NavigationBarItem navigationBarItem;

  const NavigationBarTabChanged(this.navigationBarItem);

  @override
  List<Object?> get props => [navigationBarItem];
}

class CenterMapOnUserLocationEvent extends HomeEvent {
  const CenterMapOnUserLocationEvent();

  @override
  List<Object?> get props => [];
}

class UpdateLocationCenteredStatusEvent extends HomeEvent {
  const UpdateLocationCenteredStatusEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToLocationEvent extends HomeEvent {
  final LatLng location;

  const NavigateToLocationEvent({required this.location});

  @override
  List<Object?> get props => [location];
}

class UpdateNavigationBarItemEvent extends HomeEvent {
  final NavigationBarItem navigationBarItem;

  const UpdateNavigationBarItemEvent({required this.navigationBarItem});

  @override
  List<Object?> get props => [navigationBarItem];
}