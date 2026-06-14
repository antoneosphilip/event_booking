import 'package:booking/view/widget/empty_state.dart';
import 'package:booking/view/widget/event_app_bar.dart';
import 'package:booking/view/widget/tab_bar.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const EventsAppBar(),
            const SizedBox(height: 16),
            EventTabBar(
              selectedIndex: selectedTab,
              onTabChanged: (i) => setState(() => selectedTab = i)
            ),
            const Expanded(child: EmptyState()),
          ],
        ),
      ),
    );
  }
}
