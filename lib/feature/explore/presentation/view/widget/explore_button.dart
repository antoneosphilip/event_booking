import 'package:booking/feature/explore/presentation/view/all_events/all_events_screen.dart';
import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

class ExploreButton extends StatelessWidget {
  const ExploreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AllEventsScreen(),));
        },
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EXPLORE EVENTS',
                style: TextStyle(
                  color: AppColors.textOnPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
