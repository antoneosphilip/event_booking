import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static final HiveStorage instance = HiveStorage._();
  static const usersBoxName = 'users';
  static const favoritesBoxName = 'favorites';
  static const settingsBoxName = 'settings';
  static const userIdCounterKey = 'user_id_counter';

  HiveStorage._();

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBoxName);
    await Hive.openBox(usersBoxName);
    await Hive.openBox(favoritesBoxName);
  }

  Box get settingsBox => Hive.box(settingsBoxName);

  Box get usersBox => Hive.box(usersBoxName);

  Box get favoritesBox => Hive.box(favoritesBoxName);

  int nextUserId() {
    final current = settingsBox.get(userIdCounterKey, defaultValue: 0) as int;
    final next = current + 1;
    settingsBox.put(userIdCounterKey, next);
    return next;
  }

  Future<void> close() async {
    await Hive.close();
  }
}
