import 'package:flutter/material.dart';

import '../../all_events/widget/all_event_card.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        AllEventCard(
          title: 'A virtual evening of smooth jazz',
          date: '1ST MAY- SAT -2:00 PM',
          location: 'Lot 13 • Oakland, CA',
          imagePath: 'assets/images/event_cover.png',
        ),
        AllEventCard(
          title: 'Jo malone london\'s mother\'s day',
          date: '1ST MAY- SAT -2:00 PM',
          location: 'Radius Gallery • Santa Cruz, CA',
          imagePath: 'assets/images/event_cover.png',
        ),
        AllEventCard(
          title: 'Women\'s leadership conference',
          date: '1ST MAY- SAT -2:00 PM',
          location: '53 Water St • San Francisco, CA',
          imagePath: 'assets/images/event_cover.png',
        ),
      ],
    );
  }
}
