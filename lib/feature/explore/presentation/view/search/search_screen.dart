import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';
import 'widget/search_bar_widget.dart';
import 'widget/search_event_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Search',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SearchBarWidget(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: const [
                SearchEventCard(
                  imagePath: 'assets/images/event_cover.png',
                  date: '1ST MAY- SAT -2:00 PM',
                  title: 'A virtual evening of smooth jazz',
                ),
                SearchEventCard(
                  imagePath: 'assets/images/onboarding_1.png',
                  date: '1ST MAY- SAT -2:00 PM',
                  title: "Jo malone london's mother's day",
                ),
                SearchEventCard(
                  imagePath: 'assets/images/onboarding_2.png',
                  date: '1ST MAY- SAT -2:00 PM',
                  title: "Women's leadership conference",
                ),
                SearchEventCard(
                  imagePath: 'assets/images/onboarding_3.png',
                  date: '1ST MAY- SAT -2:00 PM',
                  title: 'International kids safe parents night out',
                ),
                SearchEventCard(
                  imagePath: 'assets/images/event_cover.png',
                  date: '1ST MAY- SAT -2:00 PM',
                  title: 'International gala music festival',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
