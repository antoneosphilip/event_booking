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
    try {
      final isFav = await favoritesDataSource.isFavorite(event.id);
      if (isFav) {
        await favoritesDataSource.removeFavorite(event.id);
      } else {
        await favoritesDataSource.addFavorite(event);
      }
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
