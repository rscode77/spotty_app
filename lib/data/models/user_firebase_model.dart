class UserFirebase {
  String userId;
  String username;
  int avatarId;
  bool isOnline;
  int lastActivity;
  String? vehicle;
  String? vehicleColor;
  int? vehicleType;
  num? latitude;
  num? longitude;

  UserFirebase({
    required this.userId,
    required this.username,
    required this.avatarId,
    required this.isOnline,
    required this.lastActivity,
    required this.vehicle,
    required this.vehicleColor,
    required this.vehicleType,
    required this.latitude,
    required this.longitude,
  });

  factory UserFirebase.fromMap(String userId, Map<dynamic, dynamic> map) {
    return UserFirebase(
      userId: userId,
      username: map['username'] as String? ?? '',
      avatarId: map['avatarId'] as int? ?? 0,
      isOnline: map['isOnline'] as bool? ?? false,
      lastActivity: map['lastActivity'] as int? ?? 0,
      vehicle: map['vehicle'] as String?,
      vehicleColor: map['vehicleColor'] as String?,
      vehicleType: map['vehicleType'] as int?,
      latitude: map['latitude'] as num?,
      longitude: map['longitude'] as num?,
    );
  }
}