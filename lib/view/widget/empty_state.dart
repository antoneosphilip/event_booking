import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import 'explore_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/emptycalendar.png', width: 160, height: 160),
        const SizedBox(height: 24),
        const Text(
          'No Upcoming Event',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Lorem ipsum dolor sit amet,\nconsectetur',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 40),
        const ExploreButton(),
      ],
    );
  }
}
