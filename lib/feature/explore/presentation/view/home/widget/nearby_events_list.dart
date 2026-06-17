import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/event/events_cubit.dart';
import '../../../cubit/event/events_state.dart';
import '../../../widgets/shimmer_widgets.dart';
import '../../event/event_details.dart';
import 'nearby_event_card.dart';

class NearbyEventsList extends StatelessWidget {
  const NearbyEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      buildWhen: (previous, current) {
        if (current is! EventsLoaded) return current is EventsInitial;
        if (previous is! EventsLoaded) return true;
        return previous.exploreLoading != current.exploreLoading ||
            previous.exploreError != current.exploreError ||
            previous.nearbyEvents != current.nearbyEvents;
      },
      builder: (context, state) {
        if (state is EventsInitial ||
            (state is EventsLoaded &&
                state.exploreLoading &&
                !state.hasExploreData)) {
          return const NearbyEventsShimmer();
        }

        if (state is EventsLoaded) {
          if (state.exploreError != null && !state.hasExploreData) {
            return Center(child: Text('Error: ${state.exploreError}'));
          }

          final events = state.nearbyEvents;

          if (events.isEmpty) {
            return const Center(child: Text('No nearby events'));
          }

          return Column(
            children: events.map((event) {
              return NearbyEventCard(
                event: event,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventDetailsScreen(eventId: event.id),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }

        return const NearbyEventsShimmer();
      },
    );
  }
}
