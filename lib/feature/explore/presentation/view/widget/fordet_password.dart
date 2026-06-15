import 'package:flutter/cupertino.dart';

import 'package:booking/utils/colors.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPassword({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        'Forgot Password?',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.second,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
