import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({required this.title});

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
