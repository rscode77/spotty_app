import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/domain/entities/event_api_response.dart';

extension EventMapper on EventApiResponse {
  Event mapToEvent() {
    return Event(
      eventId: eventId,
      title: title,
      address: address,
      description: description,
      picture: picture,
      date: date,
      longitude: longitude,
      latitude: latitude,
      userId: userId,
      creationDate: creationDate,
      membersCount: membersCount,
      isPublic: isPublic,
      joined: joined,
      isOwner: isOwner,
    );
  }
}

extension EventListMapper on List<EventApiResponse> {
  List<Event> mapToEventList() {
    return map((eventApiResponse) => eventApiResponse.mapToEvent()).toList();
  }
}