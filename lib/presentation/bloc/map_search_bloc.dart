import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotty_app/data/models/recently_searched_locations_model.dart';
import 'package:spotty_app/services/common_storage.dart';
import 'package:spotty_app/services/common_storage_keys.dart';
import 'package:spotty_app/services/google_place_service.dart';

part 'map_search_event.dart';

part 'map_search_state.dart';

class MapSearchBloc extends Bloc<MapSearchEvent, MapSearchState> {
  final CommonStorage commonStorage;
  final GooglePlacesService googlePlacesService;

  MapSearchBloc({
    required this.commonStorage,
    required this.googlePlacesService,
  }) : super(const MapSearchInitial()) {
    on<MapSearchInitialEvent>(_onMapSearchInitialEvent);
    on<AddRecentlySearchedLocationEvent>(_addRecentlySearchedLocation);
    on<SearchLocationEvent>(_searchLocation);
    add(const MapSearchInitialEvent());
  }

  Future<FutureOr<void>> _onMapSearchInitialEvent(
    MapSearchInitialEvent event,
    Emitter<MapSearchState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      searchingResult: [],
    ));

    String? recentlySearchedLocationsString =
        await commonStorage.getString(CommonStorageKeys.recentlySearchedLocations);

    if (recentlySearchedLocationsString != null) {
      List<dynamic> jsonList = jsonDecode(recentlySearchedLocationsString);
      List<MapSearchLocations> recentlySearchedLocations =
          jsonList.map((json) => MapSearchLocations.fromJson(json)).toList();

      emit(state.copyWith(recentlySearchedLocations: recentlySearchedLocations));
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<FutureOr<void>> _addRecentlySearchedLocation(
    AddRecentlySearchedLocationEvent event,
    Emitter<MapSearchState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    String? recentlySearchedLocationsString =
        await commonStorage.getString(CommonStorageKeys.recentlySearchedLocations);

    List<MapSearchLocations> recentlySearchedLocations = [];

    if (recentlySearchedLocationsString != null) {
      List<dynamic> jsonList = jsonDecode(recentlySearchedLocationsString);
      recentlySearchedLocations = jsonList.map((json) => MapSearchLocations.fromJson(json)).toList();
    }

    recentlySearchedLocations.removeWhere((element) => element.coordinates == event.location.coordinates);

    if (recentlySearchedLocations.length == 10) recentlySearchedLocations.removeAt(10);

    recentlySearchedLocations.add(event.location);

    await commonStorage.putString(
      CommonStorageKeys.recentlySearchedLocations,
      jsonEncode(recentlySearchedLocations.map((location) => location.toJson()).toList()),
    );

    emit(state.copyWith(
      recentlySearchedLocations: recentlySearchedLocations,
      isLoading: false,
    ));
  }

  Future<FutureOr<void>> _searchLocation(
    SearchLocationEvent event,
    Emitter<MapSearchState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    await googlePlacesService.getSearchResults(event.placeName).then((value) {
      List<MapSearchLocations> searchedLocations = [];
      for (var candidate in value.candidates) {
        searchedLocations.add(
          MapSearchLocations(
            placeName: candidate.formattedAddress,
            coordinates: LatLng(
              candidate.geometry.location.lat,
              candidate.geometry.location.lng,
            ),
          ),
        );
      }

      emit(state.copyWith(
        isLoading: false,
        searchingResult: searchedLocations,
      ));
    }).catchError((error) {
      emit(state.copyWith(isLoading: false));
    });
  }
}
