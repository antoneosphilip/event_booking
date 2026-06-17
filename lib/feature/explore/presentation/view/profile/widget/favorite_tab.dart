import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/event_model.dart';
import '../../all_events/widget/all_event_card.dart';
import '../../../cubit/favorites/favorites_cubit.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            return const Center(child: Text('No favorite events yet.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return AllEventCard(event: state.favorites[index]);
            },
          );
        } else if (state is FavoritesError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
