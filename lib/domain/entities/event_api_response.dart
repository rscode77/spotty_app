import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_api_response.freezed.dart';
part 'event_api_response.g.dart';

@freezed
class EventApiResponse with _$EventApiResponse {
  const factory EventApiResponse({
    required int eventId,
    required String title,
    required String description,
    required String picture,
    required DateTime date,
    required double latitude,
    required double longitude,
    required int userId,
    required DateTime creationDate,
    required bool isPublic,
    required bool joined,
    required bool isOwner,
    required int membersCount,
  }) = _EventApiResponse;

  factory EventApiResponse.fromJson(Map<String, dynamic> json) => _$EventApiResponseFromJson(json);

  static List<EventApiResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => EventApiResponse.fromJson(item)).toList();
  }
}