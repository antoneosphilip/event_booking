import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/event_model.dart';
import '../../../data/datasource/favorites_local_data_source.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesLocalDataSource favoritesDataSource;

  FavoritesCubit(this.favoritesDataSource) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await favoritesDataSource.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(EventModel event) async {
    final current = state;
    if (current is FavoritesLoaded) {
      final isFav = current.favorites.any((e) => e.id == event.id);
      final updated = isFav
          ? current.favorites.where((e) => e.id != event.id).toList()
          : [...current.favorites, event];
      emit(FavoritesLoaded(updated));
    }

    try {
      final isFav = await favoritesDataSource.isFavorite(event.id);
      if (isFav) {
        await favoritesDataSource.removeFavorite(event.id);
      } else {
        await favoritesDataSource.addFavorite(event);
      }
      final favorites = await favoritesDataSource.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      await loadFavorites();
    }
  }
}
