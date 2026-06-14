import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

class EventTitle extends StatelessWidget {
  final String title;
  const EventTitle({required this.title});

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
