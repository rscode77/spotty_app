part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class RefreshTokenEvent extends HomeEvent {
  const RefreshTokenEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentUserData extends HomeEvent {
  const GetCurrentUserData();

  @override
  List<Object?> get props => [];
}
