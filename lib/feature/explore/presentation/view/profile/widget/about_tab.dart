import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        'Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More',
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: AppColors.textPrimary.withOpacity(0.8),
        ),
      ),
    );
  }
}
