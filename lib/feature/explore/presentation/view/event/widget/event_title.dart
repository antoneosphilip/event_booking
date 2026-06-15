import 'package:flutter/cupertino.dart';

import 'package:booking/utils/colors.dart';

class EventTitle extends StatelessWidget {
  final String title;
  const EventTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
    );
  }
}
