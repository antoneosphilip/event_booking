import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {'name': 'Rocks Velkeinjen', 'date': '10 Feb', 'avatar': 'assets/images/avatar1.png'},
      {'name': 'Angelina Zolly', 'date': '10 Feb', 'avatar': 'assets/images/avatar2.png'},
      {'name': 'Zenifero Bolex', 'date': '10 Feb', 'avatar': 'assets/images/avatar3.png'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(review['avatar']!),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['name']!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        review['date']!,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        Icons.star,
                        size: 16,
                        color: i < 4 ? Colors.amber : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cinemas is the ultimate experience to see new movies in Gold Class or Vmax. Find a cinema near you.',
                    style: TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
