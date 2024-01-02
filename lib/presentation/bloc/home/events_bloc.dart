import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/data/models/requests/add_event_request.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/event_api_response.dart';
import 'package:spotty_app/domain/repositories/event_repository.dart';
import 'package:spotty_app/mappers/event_mapper.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'events_event.dart';

part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository eventRepository;

  EventsBloc({required this.eventRepository}) : super(EventsInitial()) {
    on<EventsEvent>((event, emit) {});
    on<GetEvents>(_onGetEventsEvent);
    on<AddEvent>(_onAddEvent);
  }

  Future<FutureOr<void>> _onGetEventsEvent(GetEvents event, Emitter<EventsState> emit) async {
    emit(EventsLoadingState());

    Response response = await eventRepository.getEvents();

    if (response.isSuccessful()) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      List<EventApiResponse> eventApiResponse = EventApiResponse.fromJsonList(apiResponse.data as List<dynamic>);

      emit(EventsResultState(
        isSuccess: true,
        events: eventApiResponse.mapToEventList(),
      ));
    }
  }

  Future<FutureOr<void>> _onAddEvent(AddEvent event, Emitter<EventsState> emit) async {
    Response response = await eventRepository.addEvent(event.event);
  }
}
