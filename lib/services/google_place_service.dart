import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotty_app/data/models/map_location_model.dart';

class GooglePlacesService {
  GooglePlacesService();

  final String apiKey = 'AIzaSyC-BQmNQ1XPfBqpsWmS7zOc-78Y-x5mjn0';

  Future<CandidatesResponse> getSearchResults(String placeName) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$placeName%C3%B3rze&inputtype=textquery&fields=geometry,formatted_address&locationbias&key=$apiKey';

    final http.Response response = await http.get(Uri.parse(url));
    final CandidatesResponse locations = CandidatesResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      return locations;
    } else {
      throw Exception('Failed to load place coordinates');
    }
  }
}