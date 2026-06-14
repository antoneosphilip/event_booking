import 'package:flutter/material.dart';

import 'nearby_event_card.dart';

class NearbyEventsList extends StatelessWidget {
  const NearbyEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'International Band Music Concert',
        'date': 'Wed, Apr 28 · 5:30 PM',
        'location': '36 Guild Street London, UK',
        'image': 'assets/images/event_cover.png',
      },
      {
        'title': 'Jo Malone London Fragrance',
        'date': 'Sat, May 1 · 2:00 PM',
        'location': 'Radius Gallery, London',
        'image': 'assets/images/onboarding_1.png',
      },
      {
        'title': 'Summer Music Festival',
        'date': 'Mon, Jun 12 · 8:00 PM',
        'location': 'Central Park, New York',
        'image': 'assets/images/onboarding_2.png',
      },
    ];

    return Column(
      children: events.map((event) {
        return NearbyEventCard(
          title: event['title']!,
          date: event['date']!,
          location: event['location']!,
          imagePath: event['image']!,
        );
      }).toList(),
    );
  }
}
