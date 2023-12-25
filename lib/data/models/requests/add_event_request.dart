class AddEventRequest {
  final String title;
  final String description;
  final String picture;
  final DateTime date;
  final double latitude;
  final double longitude;
  final int userId;
  final bool isPublic;

  AddEventRequest({
    required this.title,
    required this.description,
    required this.picture,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.isPublic,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'picture': picture,
        'date': date,
        'latitude': latitude,
        'longitude': longitude,
        'userId': userId,
        'isPublic': isPublic,
      };
}
