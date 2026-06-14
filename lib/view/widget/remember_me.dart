import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class RememberMe extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RememberMe({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const SizedBox(width: 4),
        const Text(
          'Remember Me',
          style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
