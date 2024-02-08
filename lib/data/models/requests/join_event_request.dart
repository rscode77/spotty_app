class JoinEventRequest {
  final int userId;
  final int eventId;

  JoinEventRequest({
    required this.userId,
    required this.eventId,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'eventId': eventId,
  };
}
