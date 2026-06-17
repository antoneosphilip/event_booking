import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/explore/data/datasource/events_remote_data_source.dart';
import '../feature/explore/data/repository/events_repository.dart';
import '../feature/explore/presentation/cubit/event/events_cubit.dart';
import '../feature/explore/presentation/cubit/event_details/event_details_cubit.dart';
import '../feature/explore/presentation/cubit/search/search_cubit.dart';
import 'database/hive_storage.dart';
import 'preferences/app_preferences.dart';
import 'storage/secure_storage.dart';
import '../feature/explore/data/datasource/auth_local_data_source.dart';
import '../feature/explore/data/repository/auth_repository.dart';
import '../feature/explore/presentation/cubit/auth/auth_cubit.dart';
import '../feature/explore/data/datasource/favorites_local_data_source.dart';
import '../feature/explore/presentation/cubit/favorites/favorites_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await HiveStorage.init();

  // Core
  sl.registerLazySingleton<HiveStorage>(() => HiveStorage.instance);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sharedPreferences));
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<EventsRemoteDataSource>(
    () => EventsRemoteDataSource(),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl()),
  );
  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepository(sl()),
  );

  // Cubits
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => FavoritesCubit(sl()));
  sl.registerFactory(() => EventsCubit(sl()));
  sl.registerFactory(() => EventDetailsCubit(sl()));
  sl.registerFactory(() => SearchCubit(sl()));
}
