class Event {
  final int eventId;
  final String title;
  final String description;
  final String picture;
  final DateTime date;
  final double latitude;
  final double longitude;
  final int userId;
  final DateTime creationDate;
  final bool isPublic;
  final int membersCount;

  Event({
    required this.eventId,
    required this.title,
    required this.description,
    required this.picture,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.creationDate,
    required this.isPublic,
    required this.membersCount,
  });
}
