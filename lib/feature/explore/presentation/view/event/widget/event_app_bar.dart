import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

class EventsAppBar extends StatelessWidget {
  const EventsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(Icons.more_vert, color: AppColors.textPrimary),
        ],
      ),
    );
  }
}
