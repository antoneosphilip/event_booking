import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/event/events_cubit.dart';
import '../../../cubit/event/events_state.dart';
import '../../../widgets/shimmer_widgets.dart';
import 'event_card.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading || state is EventsInitial) {
          return const UpcomingEventsShimmer();
        }

        if (state is EventsLoaded) {
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
                return EventCard(event: events[index]);
              },
            ),
          );
        }

        if (state is EventsError) {
          return SizedBox(
            height: 260,
            child: Center(child: Text('Error: ${state.message}')),
          );
        }

        return const UpcomingEventsShimmer();
      },
    );
  }
}
