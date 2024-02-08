import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/add_event_request.dart';
import 'package:spotty_app/data/models/requests/join_event_request.dart';
import 'package:spotty_app/data/repositories/event_interface.dart';
import 'package:spotty_app/endpoints.dart';

class EventRepository implements EventInterface {
  final Dio dio;

  EventRepository({required this.dio});

  @override
  Future<Response> getEvents() async {
    final Response response = await dio.get(
      EventEndpoints.getEvents,
    );
    return response;
  }

  @override
  Future<Response> addEvent(AddEventRequest event) async {
    final Response response = await dio.post(
      EventEndpoints.addEvent,
      data: event.toJson(),
    );
    return response;
  }

  @override
  Future<Response> joinEvent(JoinEventRequest event) async {
    final Response response = await dio.post(
      EventEndpoints.joinEvent,
      data: event.toJson(),
    );
    return response;
  }

  @override
  Future<Response> leaveEvent(JoinEventRequest event) async {
    final Response response = await dio.post(
      EventEndpoints.leaveEvent,
      data: event.toJson(),
    );
    return response;
  }
}
