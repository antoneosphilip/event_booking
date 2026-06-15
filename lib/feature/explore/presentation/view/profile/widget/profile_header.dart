import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage('assets/images/organizer.png'), // Or appropriate image
        ),
        SizedBox(height: 16),
        Text(
          'David Silbia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
