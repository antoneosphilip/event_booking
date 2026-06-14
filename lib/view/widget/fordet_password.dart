import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPassword({required this.onTap});

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
