import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/domain/entities/event_api_response.dart';

extension EventMapper on EventApiResponse {
  Event mapToEvent() {
    return Event(
      eventId: eventId,
      title: title,
      description: description,
      picture: picture,
      date: date,
      longitude: longitude,
      latitude: latitude,
      userId: userId,
      creationDate: creationDate,
      membersCount: membersCount,
      isPublic: isPublic,
    );
  }
}
