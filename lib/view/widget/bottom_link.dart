import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';

class BottomLink extends StatelessWidget {
  final String question;
  final String linkText;
  final VoidCallback onTap;

  const BottomLink({
    required this.question,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: question,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            children: [
              TextSpan(
                text: linkText,
                style:  TextStyle(
                  color: AppColors.second,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
