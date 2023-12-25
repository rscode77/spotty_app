part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
}

class GetEvents extends EventsEvent {
  const GetEvents();

  @override
  List<Object> get props => [];
}

class RefreshEvents extends EventsEvent {
  const RefreshEvents();

  @override
  List<Object> get props => [];
}

class RemoveEvent extends EventsEvent {
  final String eventId;

  const RemoveEvent({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class JoinEvent extends EventsEvent {
  final String eventId;

  const JoinEvent({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class UpdateEvent extends EventsEvent {
  final Event event;

  const UpdateEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class AddEvent extends EventsEvent {
  final AddEventRequest event;

  const AddEvent({required this.event});

  @override
  List<Object> get props => [event];
}