import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/event/events_cubit.dart';
import '../../../cubit/event/events_state.dart';
import '../../../widgets/shimmer_widgets.dart';
import 'nearby_event_card.dart';

class NearbyEventsList extends StatelessWidget {
  const NearbyEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading || state is EventsInitial) {
          return const NearbyEventsShimmer();
        }

        if (state is EventsLoaded) {
          final events = state.nearbyEvents;

          if (events.isEmpty) {
            return const Center(child: Text('No nearby events'));
          }

          return Column(
            children: events.map((event) {
              return NearbyEventCard(event: event);
            }).toList(),
          );
        }

        if (state is EventsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const NearbyEventsShimmer();
      },
    );
  }
}
