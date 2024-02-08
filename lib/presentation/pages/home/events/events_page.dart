import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/event_details_arguments.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/events_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_search_bar.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/presentation/pages/home/events/events_list_view_widget.dart';
import 'package:spotty_app/routing/routing.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    super.key,
  });

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late final EventsBloc _eventsBloc;

  final TextEditingController _searchController = TextEditingController();

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _eventsBloc = context.read<EventsBloc>()..add(const GetEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPagePadding,
              ),
              child: _buildPageBody(state),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: Constants.centerAppBar,
      title: Text(
        S.of(context).events,
        style: AppTextStyles.appBarTitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildPageBody(EventsState state) {
    return Column(
      children: [
        _buildSearchBar(),
        const Space.vertical(18.0),
        _buildListView(state),
      ],
    );
  }

  Widget _buildListView(EventsState state) {
    if (state is EventsResultState && state.isSuccess) {
      return Expanded(child: _buildEventsListView(state));
    } else if (state is EventsLoadingState) {
      return const Expanded(
        child: LoadingWidget(
          size: 40.0,
          strokeWidth: 3.0,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: AppSearchBar(
            isDarkTheme: _isDarkTheme,
            hint: S.of(context).findEvent,
            searchController: _searchController,
            onSubmitted: (string) {},
          ),
        ),
        const Space.horizontal(8.0),
        _buildFilterButton(),
      ],
    );
  }

  Widget _buildFilterButton() {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: _isDarkTheme ? AppColors.lightBlue : AppColors.lightBlue,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: IconButton(
        color: AppColors.lightBlue,
        icon: const Icon(
          size: 20.0,
          LucideIcons.slidersHorizontal,
          color: AppColors.blue,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildEventsListView(EventsResultState event) {
    return _createEventsListViewWidget(
      events: event.events,
      onNavigateToEventDetails: (Event event) {
        Navigator.of(context).pushNamed(
          Routing.eventDetails,
          arguments: EventDetailsArguments(
            event: event,
            eventsBloc: _eventsBloc,
          ),
        );
      },
      onJoinEvent: (Event event) {
        context.read<EventsBloc>().add(
              event.joined ? LeaveEvent(eventId: event.eventId) : JoinEvent(eventId: event.eventId),
            );
      },
    );
  }

  Widget _createEventsListViewWidget({
    required List<Event>? events,
    required Function(Event) onNavigateToEventDetails,
    required Function(Event) onJoinEvent,
  }) {
    return EventsListViewWidget(
      events: events,
      onNavigateToEventDetails: onNavigateToEventDetails,
      onJoinEvent: onJoinEvent,
    );
  }
}