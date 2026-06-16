import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person_add_outlined, color: AppColors.primary),
          label: const Text('Follow', style: TextStyle(color: AppColors.primary)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
          label: const Text('Messages', style: TextStyle(color: AppColors.primary)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
