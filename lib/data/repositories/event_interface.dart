import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/add_event_request.dart';

abstract class EventInterface {
  Future<Response> getEvents();
  Future<Response> addEvent(AddEventRequest event);
}