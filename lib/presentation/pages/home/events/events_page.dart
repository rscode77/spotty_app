import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/presentation/bloc/home/events_bloc.dart';
import 'package:spotty_app/presentation/pages/authentication/widgets/loading_widget.dart';
import 'package:spotty_app/presentation/pages/home/events/events_list_view_widget.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    super.key,
  });

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wydarzenia'),
      ),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          return SafeArea(
            child: _buildPadeBody(state),
          );
        },
      ),
    );
  }

  Widget _buildPadeBody(EventsState state) {
    if (state is EventsResultState && state.isSuccess) {
      return _buildEventsListView(state);
    } else if (state is EventsLoadingState) {
      return const LoadingWidget();
    }
    return const SizedBox.shrink();
  }

  Widget _buildEventsListView(EventsResultState state) {
    return EventsListViewWidget(
      events: state.events,
    );
  }
}
