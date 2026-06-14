import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 24),
    );
  }
}