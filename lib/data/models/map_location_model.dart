class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({required this.northeast, required this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }
}

class Geometry {
  final Location location;
  final Viewport viewport;

  Geometry({required this.location, required this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
      viewport: Viewport.fromJson(json['viewport']),
    );
  }
}

class Candidate {
  final String formattedAddress;
  final Geometry geometry;

  Candidate({required this.formattedAddress, required this.geometry});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      formattedAddress: json['formatted_address'],
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class CandidatesResponse {
  final List<Candidate> candidates;
  final String status;

  CandidatesResponse({required this.candidates, required this.status});

  factory CandidatesResponse.fromJson(Map<String, dynamic> json) {
    var candidateList = json['candidates'] as List;
    List<Candidate> candidates = candidateList.map((i) => Candidate.fromJson(i)).toList();

    return CandidatesResponse(
      candidates: candidates,
      status: json['status'],
    );
  }
}
