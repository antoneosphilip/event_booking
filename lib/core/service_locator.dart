import 'package:get_it/get_it.dart';

import '../feature/explore/data/datasource/events_remote_data_source.dart';
import '../feature/explore/data/repository/events_repository.dart';
import '../feature/explore/presentation/cubit/events_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerFactory(() => EventsCubit(sl()));

  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepository(sl()),
  );

  sl.registerLazySingleton<EventsRemoteDataSource>(
    () => EventsRemoteDataSource(),
  );
}
