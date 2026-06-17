import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../cubit/event/events_cubit.dart';
import '../../../cubit/event/events_state.dart';
import '../../../../data/models/classification_model.dart';
import '../../../widgets/shimmer_widgets.dart';
import 'category_chip.dart';

class CategoryList extends StatefulWidget {
  final ValueChanged<ClassificationModel>? onCategorySelected;

  const CategoryList({super.key, this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  final Map<String, Map<String, dynamic>> categoryStyles = {
    'Sports': {'icon': Icons.sports_basketball, 'color': const Color(0xFFF0635A)},
    'Music': {'icon': Icons.music_note, 'color': const Color(0xFFF59762)},
    'Food': {'icon': Icons.fastfood, 'color': const Color(0xFF29D697)},
    'Art': {'icon': Icons.palette, 'color': const Color(0xFF46CDFB)},
    'Movies': {'icon': Icons.movie, 'color': const Color(0xFF7B61FF)},
    'Individual': {'icon': Icons.person, 'color': const Color(0xFFF59762)},
    'Group': {'icon': Icons.group, 'color': const Color(0xFF46CDFB)},
  };

  void _onCategoryTap(ClassificationModel category, int index) {
    setState(() => selectedIndex = index);
    context.read<EventsCubit>().fetchCategoryEvents(
          apiKey: AppConstants.apiKey,
          city: AppConstants.defaultCity,
          category: category,
        );
    widget.onCategorySelected?.call(category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      buildWhen: (previous, current) {
        if (current is! EventsLoaded) return current is EventsInitial;
        if (previous is! EventsLoaded) return true;
        return previous.exploreLoading != current.exploreLoading ||
            previous.exploreError != current.exploreError ||
            previous.classifications != current.classifications;
      },
      builder: (context, state) {
        if (state is EventsInitial ||
            (state is EventsLoaded &&
                state.exploreLoading &&
                !state.hasExploreData)) {
          return const CategoryShimmer();
        }

        if (state is EventsLoaded) {
          if (state.exploreError != null && !state.hasExploreData) {
            return SizedBox(
              height: 44,
              child: Center(child: Text('Error: ${state.exploreError}')),
            );
          }

          final classifications = state.classifications;

          if (classifications.isEmpty) {
            return const SizedBox(
              height: 44,
              child: Center(child: Text('No categories')),
            );
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
                final style = categoryStyles[cat.name] ??
                    {
                      'icon': Icons.category,
                      'color': const Color(0xFF5669FF)
                    };

                return CategoryChip(
                  icon: style['icon'] as IconData,
                  label: cat.name,
                  color: style['color'] as Color,
                  isSelected: selectedIndex == index,
                  onTap: () => _onCategoryTap(cat, index),
                );
              },
            ),
          );
        }

        return const CategoryShimmer();
      },
    );
  }
}
