import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/events_cubit.dart';
import '../../../cubit/events_state.dart';
import 'event_card.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading || state is EventsInitial) {
          return const SizedBox(
            height: 260,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is EventsLoaded) {
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
                
                final dateParts = event.date.split('-');
                final day = dateParts.length > 2 ? dateParts[2] : '00';
                final month = dateParts.length > 1 ? 'M${dateParts[1]}' : 'NA';
                
                final imageUrl = event.imageUrl.isNotEmpty ? event.imageUrl : 'assets/images/event_cover.png';
                final location = event.venueName.isNotEmpty ? event.venueName : 'Unknown Location';

                return EventCard(
                  title: event.name,
                  date: day,
                  month: month,
                  location: location,
                  imagePath: imageUrl,
                  isBookmarked: false,
                );
              },
            ),
          );
        } else if (state is EventsError) {
          return SizedBox(
            height: 260,
            child: Center(child: Text('Error: ${state.message}')),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
