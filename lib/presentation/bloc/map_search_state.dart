part of 'map_search_bloc.dart';

abstract class MapSearchState extends Equatable {
  final List<MapSearchLocations>? recentlySearchedLocations;
  final List<MapSearchLocations>? searchingResult;
  final bool isLoading;

  const MapSearchState({
    this.recentlySearchedLocations,
    this.searchingResult,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [recentlySearchedLocations, isLoading, searchingResult];

  MapSearchState copyWith({
    List<MapSearchLocations>? recentlySearchedLocations,
    List<MapSearchLocations>? searchingResult,
    bool? isLoading,
  });
}

class MapSearchInitial extends MapSearchState {
  const MapSearchInitial({
    List<MapSearchLocations>? recentlySearchedLocations,
    List<MapSearchLocations>? searchingResult,
    bool isLoading = false,
  }) : super(
    recentlySearchedLocations: recentlySearchedLocations,
    searchingResult: searchingResult,
    isLoading: isLoading,
  );

  @override
  MapSearchInitial copyWith({
    List<MapSearchLocations>? recentlySearchedLocations,
    List<MapSearchLocations>? searchingResult,
    bool? isLoading,
  }) {
    return MapSearchInitial(
      recentlySearchedLocations: recentlySearchedLocations ?? this.recentlySearchedLocations,
      searchingResult: searchingResult ?? this.searchingResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

