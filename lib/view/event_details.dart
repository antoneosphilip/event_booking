import 'package:booking/view/widget/about_section.dart';
import 'package:booking/view/widget/buy_tecket_button.dart';
import 'package:booking/view/widget/event_appbar.dart';
import 'package:booking/view/widget/event_title.dart';
import 'package:booking/view/widget/going_row.dart';
import 'package:booking/view/widget/info_title.dart';
import 'package:booking/view/widget/organize_title.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventAppBar(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      EventTitle(title: 'International Band\nMusic Concert'),
                      SizedBox(height: 20),
                      InfoTile(
                        icon: Icons.calendar_today_outlined,
                        title: '14 December, 2021',
                        subtitle: 'Tuesday, 4:00PM - 9:00PM',
                      ),
                      SizedBox(height: 12),
                      InfoTile(
                        icon: Icons.location_on_outlined,
                        title: 'Gala Convention Center',
                        subtitle: '36 Guild Street London, UK',
                      ),
                      SizedBox(height: 12),
                      OrganizerTile(
                        name: 'Ashfak Sayem',
                        role: 'Organizer',
                        imagePath: 'assets/images/organizer.png',
                      ),
                      SizedBox(height: 24),
                      AboutSection(
                        text:
                        'Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BuyTicketButton(price: '\$120'),
          ),
        ],
      ),
    );
  }
}