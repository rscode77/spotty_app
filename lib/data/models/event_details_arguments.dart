import 'package:flutter/cupertino.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/presentation/bloc/events_bloc.dart';

class EventDetailsArguments {
  Event event;
  EventsBloc eventsBloc;

  EventDetailsArguments({
    required this.event,
    required this.eventsBloc,
  });
}
