import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/services/common_storage.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CommonStorage commonStorage;

  HomeBloc({required this.commonStorage}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
  }
}
