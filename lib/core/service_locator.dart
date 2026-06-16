import 'package:get_it/get_it.dart';

import '../feature/explore/data/datasource/events_remote_data_source.dart';
import '../feature/explore/data/repository/events_repository.dart';
import '../feature/explore/presentation/cubit/event/events_cubit.dart';
import '../feature/explore/presentation/cubit/event_details/event_details_cubit.dart';
import '../feature/explore/presentation/cubit/search/search_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerFactory(() => EventsCubit(sl()));
  sl.registerFactory(() => EventDetailsCubit(sl()));
  sl.registerFactory(() => SearchCubit(sl()));

  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepository(sl()),
  );

  sl.registerLazySingleton<EventsRemoteDataSource>(
    () => EventsRemoteDataSource(),
  );
}
