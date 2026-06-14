import 'package:flutter/material.dart';

import 'event_card.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'International Band Mu...',
        'date': '10',
        'month': 'JUNE',
        'location': '36 Guild Street London, UK',
        'image': 'assets/images/event_cover.png',
      },
      {
        'title': 'Jo Malone London',
        'date': '10',
        'month': 'JUNE',
        'location': 'Radius Gallery, London',
        'image': 'assets/images/onboarding_1.png',
      },
      {
        'title': 'Music Festival 2024',
        'date': '15',
        'month': 'JUNE',
        'location': 'Central Park, NY',
        'image': 'assets/images/onboarding_2.png',
      },
    ];

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
            title: event['title']!,
            date: event['date']!,
            month: event['month']!,
            location: event['location']!,
            imagePath: event['image']!,
            isBookmarked: index == 0,
          );
        },
      ),
    );
  }
}
