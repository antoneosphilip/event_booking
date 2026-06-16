import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';

import '../../widget/going_row.dart';

class EventAppBar extends StatelessWidget {
  final String imageUrl;

  const EventAppBar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 240,
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                  ),
                )
              : Image.asset(
                  'assets/images/event_cover.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const Text(
                    'Event Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bookmark_border, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0,top: 50),
              child: GoingRow(),
            ),
          ),
        ],
      ),
    );
  }
}
