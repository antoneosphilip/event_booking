import 'package:flutter/cupertino.dart';

import 'package:booking/utils/colors.dart';

class FollowButton extends StatelessWidget {
  final VoidCallback onTap;
  const FollowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.second),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Follow',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
