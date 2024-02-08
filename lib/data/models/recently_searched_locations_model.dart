import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearchLocations {
  final LatLng coordinates;
  final String placeName;

  const MapSearchLocations({
    required this.coordinates,
    required this.placeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'coordinates': {
        'latitude': coordinates.latitude,
        'longitude': coordinates.longitude,
      },
      'placeName': placeName,
    };
  }

  factory MapSearchLocations.fromJson(Map<String, dynamic> json) {
    return MapSearchLocations(
      coordinates: LatLng(
        json['coordinates']['latitude'],
        json['coordinates']['longitude'],
      ),
      placeName: json['placeName'],
    );
  }
}