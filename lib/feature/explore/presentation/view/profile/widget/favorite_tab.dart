import 'package:flutter/material.dart';
import '../../../../data/models/event_model.dart';
import '../../all_events/widget/all_event_card.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        AllEventCard(
          event: EventModel(
            id: '1',
            name: 'A virtual evening of smooth jazz',
            date: '1ST MAY- SAT -2:00 PM',
            venueName: 'Lot 13',
            cityName: 'Oakland, CA',
            imageUrl: 'assets/images/event_cover.png',
          ),
        ),
        AllEventCard(
          event: EventModel(
            id: '2',
            name: 'Jo malone london\'s mother\'s day',
            date: '1ST MAY- SAT -2:00 PM',
            venueName: 'Radius Gallery',
            cityName: 'Santa Cruz, CA',
            imageUrl: 'assets/images/event_cover.png',
          ),
        ),
        AllEventCard(
          event: EventModel(
            id: '3',
            name: 'Women\'s leadership conference',
            date: '1ST MAY- SAT -2:00 PM',
            venueName: '53 Water St',
            cityName: 'San Francisco, CA',
            imageUrl: 'assets/images/event_cover.png',
          ),
        ),
      ],
    );
  }
}
