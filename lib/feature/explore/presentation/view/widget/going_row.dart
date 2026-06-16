import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';
import 'array_stack.dart';
import 'invite_button.dart';

class GoingRow extends StatelessWidget {
  const GoingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AvatarStack(),
          const SizedBox(width: 8),
          const Text(
            '+20 Going',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          InviteButton(onTap: () {}),
        ],
      ),
    );
  }
}
