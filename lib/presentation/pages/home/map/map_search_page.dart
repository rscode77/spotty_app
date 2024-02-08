import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/recently_searched_locations_model.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/home_bloc.dart';
import 'package:spotty_app/presentation/bloc/map_search_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_search_bar.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/utils/enums/navigation_bar_items_enum.dart';
import 'package:spotty_app/utils/extensions/int_extension.dart';
import 'package:spotty_app/utils/extensions/list_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  late final HomeBloc _homeBloc;
  late final MapSearchBloc _mapSearchBloc;

  final TextEditingController _searchController = TextEditingController();

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _mapSearchBloc = context.read<MapSearchBloc>()..add(const MapSearchInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).searchLocation),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPagePadding),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MapSearchBloc, MapSearchState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSearchBar(
                isDarkTheme: _isDarkTheme,
                hint: S.of(context).enterLocation,
                searchController: _searchController,
                onSubmitted: (placeName) => _onSearchSubmitted(placeName)),
            _buildRecentlySearchedHeader(state),
            _buildRecentlySearched(state),
            _buildBackButton(),
            const Space.vertical(24.0),
          ],
        );
      },
    );
  }

  void _onSearchSubmitted(String placeName) {
    context.read<MapSearchBloc>().add(SearchLocationEvent(placeName: placeName));
  }

  Widget _buildBackButton() {
    return AppButton(
      onPressed: () => _homeBloc.add(const UpdateNavigationBarItemEvent(navigationBarItem: NavigationBarItem.map)),
      buttonText: S.of(context).back,
      buttonColor: AppColors.blue,
    );
  }

  Widget _buildRecentlySearchedHeader(MapSearchState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.searchingResult.isNullOrEmpty ? S.of(context).recentlySearch : S.of(context).searchedLocations,
            style: AppTextStyles.textSubtitle().copyWith(
              fontWeight: FontWeight.w500,
              color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
            ),
          ),
          const Space.vertical(8.0),
          Divider(
            color: _isDarkTheme ? DarkAppColors.divider : LightAppColors.divider,
            thickness: 0.6,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlySearched(MapSearchState state) {
    if (state.isLoading) {
      return const Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 24.0),
          child: LoadingWidget(
            size: 40.0,
            strokeWidth: 3.0,
          ),
        ),
      );
    }
    if (state.recentlySearchedLocations.isNullOrEmpty && state.searchingResult.isNullOrEmpty) {
      return _buildNoResults();
    }
    if (state.searchingResult.isNotNullOrEmpty) {
      return _buildSearchResults(state.searchingResult.orEmpty());
    }
    return Expanded(
      child: ListView.builder(
        itemCount: state.recentlySearchedLocations?.length.orZero(),
        itemBuilder: (context, index) {
          final MapSearchLocations location = state.recentlySearchedLocations![index];
          return _buildFoundItem(
            location: location,
            isSearchingResult: false,
          );
        },
      ),
    );
  }

  Widget _buildFoundItem({
    required MapSearchLocations location,
    required bool isSearchingResult,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          _homeBloc.add(NavigateToLocationEvent(
            location: LatLng(
              location.coordinates.latitude,
              location.coordinates.longitude,
            ),
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: _isDarkTheme ? DarkAppColors.inactive : LightAppColors.inactive,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearchingResult ? LucideIcons.mapPin : LucideIcons.clock,
                color: _isDarkTheme ? DarkAppColors.iconDark : LightAppColors.iconDark,
                size: 20.0,
              ),
            ),
            const Space.horizontal(AppDimensions.defaultPadding),
            Text(location.placeName),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<MapSearchLocations> locations) {
    return Expanded(
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final MapSearchLocations location = locations[index];
          return _buildFoundItem(
            location: location,
            isSearchingResult: true,
          );
        },
      ),
    );
  }

  Widget _buildNoResults() {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.defaultPagePadding),
      child: Text(
        S.of(context).noResults,
        style: AppTextStyles.textSubtitle().copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
