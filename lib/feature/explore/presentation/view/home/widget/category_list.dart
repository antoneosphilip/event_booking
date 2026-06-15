import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/events_cubit.dart';
import '../../../cubit/events_state.dart';
import 'category_chip.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  // Fallback styling for categories if they match these names, else generic styling
  final Map<String, Map<String, dynamic>> categoryStyles = {
    'Sports': {'icon': Icons.sports_basketball, 'color': const Color(0xFFF0635A)},
    'Music': {'icon': Icons.music_note, 'color': const Color(0xFFF59762)},
    'Food': {'icon': Icons.fastfood, 'color': const Color(0xFF29D697)},
    'Art': {'icon': Icons.palette, 'color': const Color(0xFF46CDFB)},
    'Movies': {'icon': Icons.movie, 'color': const Color(0xFF7B61FF)},
    'Individual': {'icon': Icons.person, 'color': const Color(0xFFF59762)},
    'Group': {'icon': Icons.group, 'color': const Color(0xFF46CDFB)},
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading || state is EventsInitial) {
          return const SizedBox(
            height: 44,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is EventsLoaded) {
          final classifications = state.classifications;
          
          if (classifications.isEmpty) {
            return const SizedBox(height: 44, child: Center(child: Text('No categories')));
          }

          return SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: classifications.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final cat = classifications[index];
                final style = categoryStyles[cat.name] ?? {'icon': Icons.category, 'color': const Color(0xFF5669FF)};
                
                return CategoryChip(
                  icon: style['icon'] as IconData,
                  label: cat.name,
                  color: style['color'] as Color,
                  isSelected: selectedIndex == index,
                  onTap: () => setState(() => selectedIndex = index),
                );
              },
            ),
          );
        } else if (state is EventsError) {
          return SizedBox(height: 44, child: Center(child: Text('Error: ${state.message}')));
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
