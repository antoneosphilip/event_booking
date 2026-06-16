import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  final List<String> images = const [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
  ];

  const AvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 36,
      child: Stack(
        children: List.generate(images.length, (i) {
          return Positioned(
            left: i * 22.0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: AssetImage(images[i]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
