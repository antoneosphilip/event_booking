import 'package:flutter/cupertino.dart';

import 'package:booking/utils/colors.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}
