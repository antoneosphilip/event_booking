import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/events_repository.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventsRepository repository;

  EventsCubit(this.repository) : super(EventsInitial());

  static EventsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchExploreData({
    required String apiKey,
    required String city,
    required String latlong,
  }) async {
    emit(EventsLoading());
    try {
      final classifications = await repository.getClassifications(apiKey);
      final upcomingEvents = await repository.getUpcomingEvents(apiKey, city);
      final nearbyEvents = await repository.getNearbyEvents(apiKey, latlong);
      
      final allUpcomingEvents = await repository.getAllUpcomingEvents(apiKey, city);
      final pastEvents = await repository.getPastEvents(apiKey, city);

      emit(EventsLoaded(
        classifications: classifications,
        upcomingEvents: upcomingEvents,
        nearbyEvents: nearbyEvents,
        allUpcomingEvents: allUpcomingEvents,
        pastEvents: pastEvents,
      ));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
