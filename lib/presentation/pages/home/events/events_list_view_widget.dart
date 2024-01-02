import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/event_model.dart';
import 'package:spotty_app/presentation/bloc/login/login_bloc.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';

class EventsListViewWidget extends StatefulWidget {
  final List<Event>? events;

  const EventsListViewWidget({
    super.key,
    required this.events,
  });

  @override
  State<EventsListViewWidget> createState() => _EventsListViewWidgetState();
}

class _EventsListViewWidgetState extends State<EventsListViewWidget> {
  late final LoginBloc _loginBloc;

  @override
  initState() {
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListView(),
      ],
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.events?.length,
        itemBuilder: (context, index) {
          Event? event = widget.events?[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${event?.title.orEmpty()}'),
                    Text('${widget.events?[index].description.orEmpty()}'),
                  ],
                ),
                const Spacer(),
                _joined(event?.joined ?? false),
                _editEvent(event?.isOwner ?? false),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _joined(bool isJoined) {
    return isJoined
        ? const Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : const SizedBox.shrink();
  }

  Widget _editEvent(bool isOwner) {
    return isOwner
        ? InkWell(
            onTap: () => {},
            child: const Icon(Icons.edit),
          )
        : const SizedBox.shrink();
  }
}
