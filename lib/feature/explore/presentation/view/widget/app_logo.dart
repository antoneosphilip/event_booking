import 'package:flutter/cupertino.dart';

import 'package:booking/utils/colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/images/app_logo.png', width: 80, height: 80),
          const SizedBox(height: 8),
          const Text(
            'EventHub',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
