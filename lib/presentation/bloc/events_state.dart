part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  final List<Event> events;

  const EventsState({required this.events});

  @override
  List<Object> get props => [events];
}

class EventsInitial extends EventsState {
  EventsInitial({List<Event>? events}) : super(events: events ?? []);

  EventsInitial copyWith({List<Event>? events}) {
    return EventsInitial(events: events ?? this.events);
  }
}

class EventsLoadingState extends EventsState {
  EventsLoadingState({List<Event>? events}) : super(events: events ?? []);

  EventsLoadingState copyWith({List<Event>? events}) {
    return EventsLoadingState(events: events ?? this.events);
  }
}

class EventsResultState extends EventsState {
  final bool isSuccess;

  const EventsResultState({
    required this.isSuccess,
    required List<Event> events,
  }) : super(events: events);

  EventsResultState copyWith({
    bool? isSuccess,
    List<Event>? events,
  }) {
    return EventsResultState(
      isSuccess: isSuccess ?? this.isSuccess,
      events: events ?? this.events,
    );
  }

  @override
  List<Object> get props => [isSuccess, events];
}