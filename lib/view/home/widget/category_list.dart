import 'package:flutter/material.dart';

import 'category_chip.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.sports_basketball, 'label': 'Sports', 'color': const Color(0xFFF0635A)},
    {'icon': Icons.music_note, 'label': 'Music', 'color': const Color(0xFFF59762)},
    {'icon': Icons.fastfood, 'label': 'Food', 'color': const Color(0xFF29D697)},
    {'icon': Icons.palette, 'label': 'Art', 'color': const Color(0xFF46CDFB)},
    {'icon': Icons.movie, 'label': 'Movies', 'color': const Color(0xFF7B61FF)},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return CategoryChip(
            icon: cat['icon'] as IconData,
            label: cat['label'] as String,
            color: cat['color'] as Color,
            isSelected: selectedIndex == index,
            onTap: () => setState(() => selectedIndex = index),
          );
        },
      ),
    );
  }
}
