import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/event/events_cubit.dart';
import '../../../cubit/event/events_state.dart';
import '../../../widgets/shimmer_widgets.dart';
import '../../event/event_details.dart';
import 'event_card.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      buildWhen: (previous, current) {
        if (current is! EventsLoaded) return current is EventsInitial;
        if (previous is! EventsLoaded) return true;
        return previous.exploreLoading != current.exploreLoading ||
            previous.exploreError != current.exploreError ||
            previous.upcomingEvents != current.upcomingEvents;
      },
      builder: (context, state) {
        if (state is EventsInitial ||
            (state is EventsLoaded &&
                state.exploreLoading &&
                !state.hasExploreData)) {
          return const UpcomingEventsShimmer();
        }

        if (state is EventsLoaded) {
          if (state.exploreError != null && !state.hasExploreData) {
            return SizedBox(
              height: 260,
              child: Center(child: Text('Error: ${state.exploreError}')),
            );
          }

          final events = state.upcomingEvents;

          if (events.isEmpty) {
            return const SizedBox(
              height: 260,
              child: Center(child: Text('No upcoming events')),
            );
          }

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: events.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
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
              },
            ),
          );
        }

        return const UpcomingEventsShimmer();
      },
    );
  }
}
