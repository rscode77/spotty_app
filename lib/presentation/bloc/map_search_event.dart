part of 'map_search_bloc.dart';

abstract class MapSearchEvent extends Equatable {
  const MapSearchEvent();
}

class MapSearchInitialEvent extends MapSearchEvent {
  const MapSearchInitialEvent();

  @override
  List<Object> get props => [];
}

class AddRecentlySearchedLocationEvent extends MapSearchEvent {
  final MapSearchLocations location;

  const AddRecentlySearchedLocationEvent({required this.location});

  @override
  List<Object> get props => [location];
}

class SearchLocationEvent extends MapSearchEvent {
  final String placeName;

  const SearchLocationEvent({required this.placeName});

  @override
  List<Object> get props => [placeName];
}