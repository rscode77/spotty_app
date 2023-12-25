import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/add_event_request.dart';
import 'package:spotty_app/data/repositories/event_interface.dart';
import 'package:spotty_app/endpoints.dart';

class EventRepository implements EventInterface {
  final Dio dio;

  EventRepository({required this.dio});

  @override
  Future<Response> getEvents() async {
    final Response response = await dio.get(
      EventEdnpoints.getEvents,
    );
    return response;
  }

  @override
  Future<Response> addEvent(AddEventRequest event) async {
    final Response response = await dio.post(
      EventEdnpoints.addEvent,
      data: event.toJson(),
    );
    return response;
  }
}
