import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/event_model.dart';
import '../../../data/repository/events_repository.dart';
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

      emit(EventsLoaded(
        classifications: classifications,
        upcomingEvents: upcomingEvents,
        nearbyEvents: nearbyEvents,
      ));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
  Future<void> fetchAllEvents({
    required String apiKey,
    required String city,
  }) async {
    emit(AllEventsLoading());

    try {
      final upcomingEvents =
      await repository.getAllUpcomingEvents(apiKey, city);

      final pastEvents =
      await repository.getPastEvents(apiKey, city);

      emit(
        AllEventsLoaded(
          upcomingEvents: upcomingEvents,
          pastEvents: pastEvents,
        ),
      );
    } catch (e) {
      emit(AllEventsError(e.toString()));
    }
  }
}
