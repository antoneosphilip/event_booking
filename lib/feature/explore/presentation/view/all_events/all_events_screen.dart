import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';
import 'widget/all_event_card.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': "Jo Malone London's Mother's Day Presents",
        'date': 'Wed, Apr 28 · 5:30 PM',
        'location': 'Radius Gallery • Santa Cruz, CA',
        'image': 'assets/images/onboarding_1.png',
      },
      {
        'title': 'A Virtual Evening of Smooth Jazz',
        'date': 'Sat, May 1 · 2:00 PM',
        'location': 'Lot 13 • Oakland, CA',
        'image': 'assets/images/onboarding_2.png',
      },
      {
        'title': "Women's Leadership Conference 2021",
        'date': 'Sat, Apr 24 · 1:30 PM',
        'location': '53 Bush St • San Francisco, CA',
        'image': 'assets/images/onboarding_3.png',
      },
      {
        'title': 'International Kids Safe Parents Night Out',
        'date': 'Fri, Apr 23 · 6:00 PM',
        'location': 'Lot 13 • Oakland, CA',
        'image': 'assets/images/onboarding_1.png',
      },
      {
        'title': 'Collectivity Plays the Music of Jimi',
        'date': 'Mon, Jun 21 · 10:00 PM',
        'location': 'Longboard Margarita Bar',
        'image': 'assets/images/onboarding_2.png',
      },
      {
        'title': 'International Gala Music Festival',
        'date': 'Sun, Apr 25 · 10:15 AM',
        'location': '36 Guild Street London, UK',
        'image': 'assets/images/event_cover.png',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Events',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return AllEventCard(
            title: event['title']!,
            date: event['date']!,
            location: event['location']!,
            imagePath: event['image']!,
          );
        },
      ),
    );
  }
}
