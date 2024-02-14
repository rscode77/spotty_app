import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/event_details_arguments.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/events_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/extensions/datetime_extension.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    super.key,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late final Event _event;
  late final EventDetailsArguments _args;

  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as EventDetailsArguments;
    _event = _args.event;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPagePadding,
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: Constants.centerAppBar,
      title: Text(
        _event.title,
        style: AppTextStyles.appBarTitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        _buildEventDetails(),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      height: 140.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(_event.picture),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildEventDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space.vertical(AppDimensions.defaultPadding),
          _buildTitle(),
          const Space.vertical(AppDimensions.defaultPadding),
          _buildLocation(),
          const Space.vertical(12.0),
          _buildDate(),
          const Space.vertical(12.0),
          _buildMembers(),
          const Space.vertical(AppDimensions.defaultPadding),
          _buildDescriptionTitle(),
          const Space.vertical(12.0),
          _buildDescription(),
          const Spacer(),
          _buildNavigationButton(),
          const Space.vertical(8.0),
          _buildJoinButton(),
          const Space.vertical(24.0),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      S.of(context).eventDetails,
      style: AppTextStyles.eventTitle().copyWith(
        color: _isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
      ),
    );
  }

  Widget _buildDescriptionTitle() {
    return Text(
      S.of(context).eventDescription,
      style: AppTextStyles.eventTitle().copyWith(
        color: _isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      decoration: BoxDecoration(
          color: _isDarkTheme ? DarkAppColors.inactive : LightAppColors.inactive,
          borderRadius: BorderRadius.circular(16.0)),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        _event.description,
        style: AppTextStyles.eventDescription().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          LucideIcons.mapPin,
          color: _isDarkTheme ? DarkAppColors.lightGray : LightAppColors.lightGray,
          size: 20.0,
        ),
        const Space.horizontal(8.0),
        Text(
          _event.address,
          style: AppTextStyles.eventInformation().copyWith(
            color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildDate() {
    return Row(
      children: [
        Icon(
          LucideIcons.calendar,
          color: _isDarkTheme ? DarkAppColors.lightGray : LightAppColors.lightGray,
          size: 20.0,
        ),
        const Space.horizontal(8.0),
        Text(
          _event.date.getFullDate,
          style: AppTextStyles.eventInformation().copyWith(
            color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildMembers() {
    return Row(
      children: [
        Icon(
          LucideIcons.users,
          color: _isDarkTheme ? DarkAppColors.lightGray : LightAppColors.lightGray,
          size: 20.0,
        ),
        const Space.horizontal(8.0),
        BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            return Text(
              state.events.firstWhere((element) => element.eventId == _event.eventId).membersCount.toString(),
              style: AppTextStyles.eventInformation().copyWith(
                color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
              ),
            );
          },
        ),
      ],
    );
  }


  // TODO add navigate to event use default system map
  Widget _buildNavigationButton() {
    return AppButton(
      onPressed: () => {},
      buttonText: S.of(context).navigate,
      buttonTextColor: AppColors.blue,
      buttonColor: AppColors.lightBlue,
    );
  }

  Widget _buildJoinButton() {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        bool isJoined = state.events.firstWhere((element) => element.eventId == _event.eventId).joined;
        return AppButton(
          onPressed: () => context
              .read<EventsBloc>()
              .add(isJoined ? LeaveEvent(eventId: _event.eventId) : JoinEvent(eventId: _event.eventId)),
          buttonText: isJoined ? S.of(context).leaveEvent : S.of(context).joinToEvent,
          buttonTextColor: isJoined
              ? _isDarkTheme
                  ? DarkAppColors.inactiveText
                  : LightAppColors.inactiveText
              : AppColors.white,
          buttonColor: isJoined
              ? _isDarkTheme
                  ? DarkAppColors.inactive
                  : LightAppColors.inactive
              : AppColors.blue,
        );
      },
    );
  }
}
