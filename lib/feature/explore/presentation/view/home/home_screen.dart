import 'package:flutter/material.dart';

import 'widget/category_list.dart';
import 'widget/home_app_bar.dart';
import 'widget/invite_banner.dart';
import 'widget/nearby_events_list.dart';
import 'widget/section_header.dart';
import 'widget/upcoming_events_list.dart';
class HomeScreen extends StatelessWidget {
  final VoidCallback onDrawerTap;

  const HomeScreen({super.key, required this.onDrawerTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(onDrawerTap: onDrawerTap),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CategoryList(),
                const SizedBox(height: 24),
                SectionHeader(title: 'Upcoming Events', onSeeAll: () {}),
                const SizedBox(height: 16),
                const UpcomingEventsList(),
                const SizedBox(height: 24),
                const InviteBanner(),
                const SizedBox(height: 24),
                SectionHeader(title: 'Nearby You', onSeeAll: () {}),
                const SizedBox(height: 8),
                const NearbyEventsList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
