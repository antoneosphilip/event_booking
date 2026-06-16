import 'package:booking/feature/explore/presentation/view/event/events_screen.dart';
import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

class BuyTicketButton extends StatelessWidget {
  final String price;
  const BuyTicketButton({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen()));
        },
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BUY TICKET $price',
                style: const TextStyle(
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
