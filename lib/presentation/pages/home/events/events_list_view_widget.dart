import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/login_bloc.dart';
import 'package:spotty_app/utils/extensions/datetime_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class EventsListViewWidget extends StatefulWidget {
  final List<Event>? events;
  final Function(Event) onNavigateToEventDetails;
  final Function(Event) onJoinEvent;

  const EventsListViewWidget({
    super.key,
    required this.events,
    required this.onJoinEvent,
    required this.onNavigateToEventDetails,
  });

  @override
  State<EventsListViewWidget> createState() => _EventsListViewWidgetState();
}

class _EventsListViewWidgetState extends State<EventsListViewWidget> {
  late final LoginBloc _loginBloc;

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  initState() {
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 8.0,
      ),
      child: ListView.builder(
        itemCount: widget.events?.length,
        itemBuilder: (context, index) {
          Event? event = widget.events?[index];
          return _buildEventItem(event: event);
        },
      ),
    );
  }

  Widget _buildEventItem({required Event? event}) {
    return InkWell(
      onTap: () => widget.onNavigateToEventDetails(event),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventHeader(event),
            const Space.vertical(12.0),
            _buildDescription(event),
            const Space.vertical(12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildMembers(event),
                const Space.horizontal(16.0),
                _buildDate(event!),
                const Space.horizontal(16.0),
                _buildDistance(),
                const Spacer(),
                _showEventDetails(),
              ],
            ),
            const Space.vertical(12.0),
            Divider(
              color: _isDarkTheme ? DarkAppColors.divider : LightAppColors.divider,
              thickness: 0.6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHeader(Event? event) {
    return Row(
      children: [
        _buildImage(event),
        const Space.horizontal(12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(event),
            _buildLocation(event),
          ],
        ),
        const Spacer(),
        _buildJoinButton(event!),
      ],
    );
  }

  Widget _buildImage(Event? event) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(event!.picture),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle(Event? event) {
    String? title = event!.title.orEmpty().length > 20 ? '${event.title.substring(0, 20)}...' : event.title.orEmpty();
    return Text(
      title,
      style: AppTextStyles.eventTitle().copyWith(
        color: _isDarkTheme ? DarkAppColors.white : LightAppColors.darkText,
      ),
    );
  }

  Widget _buildDescription(Event? event) {
    return Container(
      decoration: BoxDecoration(
        color: _isDarkTheme ? DarkAppColors.inactive : LightAppColors.inactive,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '${event?.description.orEmpty()}',
        style: AppTextStyles.eventSubtitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
    );
  }

  Widget _buildLocation(Event? event) {
    String? address =
        event!.address.orEmpty().length > 23 ? '${event.address.substring(0, 23)}...' : event.address.orEmpty();
    return Row(
      children: [
        Text(
          address,
          style: AppTextStyles.eventSubtitle().copyWith(
            color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
          ),
        ),
      ],
    );
  }

  Widget _buildJoinButton(Event event) {
    return InkWell(
      onTap: () => widget.onJoinEvent(event),
      child: Container(
        height: 37.0,
        width: 78.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: event.joined
              ? _isDarkTheme
                  ? DarkAppColors.inactive
                  : LightAppColors.inactive
              : AppColors.lightBlue,
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        ),
        child: Center(
          child: Text(
            event.joined ? S.of(context).leave : S.of(context).join,
            style: AppTextStyles.infoSmall().copyWith(
              fontWeight: FontWeight.w500,
              color: event.joined
                  ? _isDarkTheme
                      ? DarkAppColors.inactiveText
                      : LightAppColors.inactiveText
                  : AppColors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDate(Event event) {
    return Row(
      children: [
        Icon(
          size: 18.0,
          LucideIcons.calendar,
          color: _isDarkTheme ? DarkAppColors.grayIcon : LightAppColors.grayIcon,
        ),
        const Space.horizontal(4.0),
        Text(
          event.date.getFullDate,
          style: AppTextStyles.infoSmall().copyWith(
            color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
          ),
        ),
      ],
    );
  }

  Widget _buildMembers(Event? event) {
    return InkWell(
      onTap: () => {},
      child: Row(
        children: [
          Icon(
            size: 18.0,
            LucideIcons.users,
            color: _isDarkTheme ? DarkAppColors.grayIcon : LightAppColors.grayIcon,
          ),
          const Space.horizontal(4.0),
          Text(
            (event?.membersCount ?? 0).toString(),
            style: AppTextStyles.infoSmall().copyWith(
              color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistance() {
    return Row(
      children: [
        Icon(
          size: 18.0,
          LucideIcons.mapPin,
          color: _isDarkTheme ? DarkAppColors.grayIcon : LightAppColors.grayIcon,
        ),
        const Space.horizontal(4.0),
        Text(
          '2.5 km',
          style: AppTextStyles.infoSmall().copyWith(
            color: _isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
          ),
        ),
      ],
    );
  }

  Widget _showEventDetails() {
    return Row(
      children: [
        Icon(
          LucideIcons.gripHorizontal,
          size: 20.0,
          color: _isDarkTheme ? DarkAppColors.grayIcon : LightAppColors.grayIcon,
        ),
      ],
    );
  }
}