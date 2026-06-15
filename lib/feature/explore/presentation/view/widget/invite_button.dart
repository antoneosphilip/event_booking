import 'package:flutter/cupertino.dart';

import 'package:booking/utils/colors.dart';

class InviteButton extends StatelessWidget {
  final VoidCallback onTap;
  const InviteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Invite',
          style: TextStyle(
            color: AppColors.textOnPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
