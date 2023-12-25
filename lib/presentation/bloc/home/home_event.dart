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