import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/data/models/requests/add_event_request.dart';
import 'package:spotty_app/data/models/requests/join_event_request.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/domain/entities/event_api_response.dart';
import 'package:spotty_app/domain/repositories/event_repository.dart';
import 'package:spotty_app/mappers/event_mapper.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

part 'events_event.dart';

part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository eventRepository;
  final LoginBloc loginBloc;

  EventsBloc({
    required this.eventRepository,
    required this.loginBloc,
  }) : super(EventsInitial()) {
    on<EventsEvent>((event, emit) {});
    on<GetEvents>(_onGetEventsEvent);
    on<AddEvent>(_onAddEvent);
    on<JoinEvent>(_onJoinEvent);
    on<LeaveEvent>(_onLeaveEvent);
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

    if(response.isUnauthorized()){

    }
  }

  Future<FutureOr<void>> _onAddEvent(AddEvent event, Emitter<EventsState> emit) async {
    Response response = await eventRepository.addEvent(event.event);
  }

  Future<FutureOr<void>> _onJoinEvent(JoinEvent event, Emitter<EventsState> emit) async {
    Response response = await eventRepository.joinEvent(
      JoinEventRequest(
        eventId: event.eventId,
        userId: loginBloc.loggedInUserId,
      ),
    );

    if (response.isSuccessful()) {
      List<Event> updatedEvents = state.events.map((e) {
        if (e.eventId == event.eventId) {
          return e.copyWith(joined: true, membersCount: e.membersCount + 1);
        } else {
          return e;
        }
      }).toList();

      emit(EventsResultState(isSuccess: true, events: updatedEvents));
    }
  }

  Future<FutureOr<void>> _onLeaveEvent(LeaveEvent event, Emitter<EventsState> emit) async {
    Response response = await eventRepository.leaveEvent(
      JoinEventRequest(
        eventId: event.eventId,
        userId: loginBloc.loggedInUserId,
      ),
    );

    if (response.isSuccessful()) {
      List<Event> updatedEvents = state.events.map((e) {
        if (e.eventId == event.eventId) {
          return e.copyWith(joined: false, membersCount: e.membersCount - 1);
        } else {
          return e;
        }
      }).toList();

      emit(EventsResultState(isSuccess: true, events: updatedEvents));
    }
  }
}
