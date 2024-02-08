class Event {
  final int eventId;
  final String title;
  final String address;
  final String description;
  final String picture;
  final DateTime date;
  final double latitude;
  final double longitude;
  final int userId;
  final DateTime creationDate;
  final bool isPublic;
  final bool joined;
  final bool isOwner;
  final int membersCount;

  Event({
    required this.eventId,
    required this.title,
    required this.address,
    required this.description,
    required this.picture,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.creationDate,
    required this.isPublic,
    required this.joined,
    required this.isOwner,
    required this.membersCount,
  });

  Event copyWith({
    int? eventId,
    String? title,
    String? address,
    String? description,
    String? picture,
    DateTime? date,
    double? latitude,
    double? longitude,
    int? userId,
    DateTime? creationDate,
    bool? isPublic,
    bool? joined,
    bool? isOwner,
    int? membersCount,
  }) {
    return Event(
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      address: address ?? this.address,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      date: date ?? this.date,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userId: userId ?? this.userId,
      creationDate: creationDate ?? this.creationDate,
      isPublic: isPublic ?? this.isPublic,
      joined: joined ?? this.joined,
      isOwner: isOwner ?? this.isOwner,
      membersCount: membersCount ?? this.membersCount,
    );
  }
}