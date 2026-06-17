import '../../../../core/database/hive_storage.dart';
import '../models/event_model.dart';

abstract class FavoritesLocalDataSource {
  Future<void> addFavorite(EventModel event);
  Future<void> removeFavorite(String id);
  Future<List<EventModel>> getFavorites();
  Future<bool> isFavorite(String id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final HiveStorage hiveStorage;

  FavoritesLocalDataSourceImpl(this.hiveStorage);

  @override
  Future<void> addFavorite(EventModel event) async {
    await hiveStorage.favoritesBox.put(event.id, event.toMap());
  }

  @override
  Future<void> removeFavorite(String id) async {
    await hiveStorage.favoritesBox.delete(id);
  }

  @override
  Future<List<EventModel>> getFavorites() async {
    return hiveStorage.favoritesBox.values
        .map((data) => EventModel.fromMap(Map<String, dynamic>.from(data as Map)))
        .toList();
  }

  @override
  Future<bool> isFavorite(String id) async {
    return hiveStorage.favoritesBox.containsKey(id);
  }
}
