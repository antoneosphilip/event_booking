import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/events_cubit.dart';
import '../../../cubit/events_state.dart';
import 'nearby_event_card.dart';

class NearbyEventsList extends StatelessWidget {
  const NearbyEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading || state is EventsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventsLoaded) {
          final events = state.nearbyEvents;

          if (events.isEmpty) {
            return const Center(child: Text('No nearby events'));
          }

          return Column(
            children: events.map((event) {
              final imageUrl = event.imageUrl.isNotEmpty ? event.imageUrl : 'assets/images/event_cover.png';
              final location = event.venueName.isNotEmpty ? event.venueName : 'Unknown Location';

              return NearbyEventCard(
                title: event.name,
                date: event.date,
                location: location,
                imagePath: imageUrl,
              );
            }).toList(),
          );
        } else if (state is EventsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
