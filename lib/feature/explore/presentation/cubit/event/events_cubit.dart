import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/classification_model.dart';
import '../../../data/repository/events_repository.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventsRepository repository;

  EventsCubit(this.repository) : super(EventsInitial());

  static EventsCubit get(context) => BlocProvider.of(context);

  EventsLoaded _currentLoaded() {
    return state is EventsLoaded
        ? state as EventsLoaded
        : const EventsLoaded();
  }

  Future<void> fetchExploreData({
    required String apiKey,
    required String city,
    required String latlong,
  }) async {
    final current = _currentLoaded();
    emit(current.copyWith(exploreLoading: true, clearExploreError: true));

    try {
      final classifications = await repository.getClassifications(apiKey);
      final upcomingEvents = await repository.getUpcomingEvents(apiKey, city);
      final nearbyEvents = await repository.getNearbyEvents(apiKey, latlong);

      emit(_currentLoaded().copyWith(
        exploreLoading: false,
        classifications: classifications,
        upcomingEvents: upcomingEvents,
        nearbyEvents: nearbyEvents,
      ));
    } catch (e) {
      final loaded = _currentLoaded();
      if (loaded.hasExploreData) {
        emit(loaded.copyWith(exploreLoading: false));
      } else {
        emit(loaded.copyWith(
          exploreLoading: false,
          exploreError: e.toString(),
        ));
      }
    }
  }

  Future<void> fetchAllEvents({
    required String apiKey,
    required String city,
  }) async {
    emit(_currentLoaded().copyWith(
      allEventsLoading: true,
      clearAllEventsError: true,
    ));

    try {
      final upcomingEvents =
          await repository.getAllUpcomingEvents(apiKey, city);
      final pastEvents = await repository.getPastEvents(apiKey, city);

      emit(_currentLoaded().copyWith(
        allEventsLoading: false,
        allUpcomingEvents: upcomingEvents,
        pastEvents: pastEvents,
      ));
    } catch (e) {
      emit(_currentLoaded().copyWith(
        allEventsLoading: false,
        allEventsError: e.toString(),
      ));
    }
  }

  Future<void> fetchCategoryEvents({
    required String apiKey,
    required String city,
    required ClassificationModel category,
  }) async {
    emit(_currentLoaded().copyWith(
      selectedCategoryId: category.id,
      selectedCategoryName: category.name,
      categoryEventsLoading: true,
      clearCategoryError: true,
    ));

    try {
      final events = await repository.getEventsByClassification(
        apiKey,
        city,
        category.id,
      );

      emit(_currentLoaded().copyWith(
        categoryEventsLoading: false,
        categoryEvents: events,
      ));
    } catch (e) {
      emit(_currentLoaded().copyWith(
        categoryEventsLoading: false,
        categoryEventsError: e.toString(),
      ));
    }
  }

  void clearCategoryFilter() {
    if (state is EventsLoaded) {
      emit((state as EventsLoaded).copyWith(clearCategory: true));
    }
  }
}
