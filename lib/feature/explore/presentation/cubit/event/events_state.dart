import 'package:equatable/equatable.dart';

import '../../../data/models/classification_model.dart';
import '../../../data/models/event_model.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoaded extends EventsState {
  final List<ClassificationModel> classifications;
  final List<EventModel> upcomingEvents;
  final List<EventModel> nearbyEvents;
  final bool exploreLoading;
  final String? exploreError;

  final List<EventModel> allUpcomingEvents;
  final List<EventModel> pastEvents;
  final bool allEventsLoading;
  final String? allEventsError;

  final String? selectedCategoryId;
  final String? selectedCategoryName;
  final List<EventModel> categoryEvents;
  final bool categoryEventsLoading;
  final String? categoryEventsError;

  const EventsLoaded({
    this.classifications = const [],
    this.upcomingEvents = const [],
    this.nearbyEvents = const [],
    this.exploreLoading = false,
    this.exploreError,
    this.allUpcomingEvents = const [],
    this.pastEvents = const [],
    this.allEventsLoading = false,
    this.allEventsError,
    this.selectedCategoryId,
    this.selectedCategoryName,
    this.categoryEvents = const [],
    this.categoryEventsLoading = false,
    this.categoryEventsError,
  });

  bool get hasExploreData =>
      classifications.isNotEmpty ||
      upcomingEvents.isNotEmpty ||
      nearbyEvents.isNotEmpty;

  EventsLoaded copyWith({
    List<ClassificationModel>? classifications,
    List<EventModel>? upcomingEvents,
    List<EventModel>? nearbyEvents,
    bool? exploreLoading,
    String? exploreError,
    bool clearExploreError = false,
    List<EventModel>? allUpcomingEvents,
    List<EventModel>? pastEvents,
    bool? allEventsLoading,
    String? allEventsError,
    bool clearAllEventsError = false,
    String? selectedCategoryId,
    String? selectedCategoryName,
    List<EventModel>? categoryEvents,
    bool? categoryEventsLoading,
    String? categoryEventsError,
    bool clearCategory = false,
    bool clearCategoryError = false,
  }) {
    return EventsLoaded(
      classifications: classifications ?? this.classifications,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      exploreLoading: exploreLoading ?? this.exploreLoading,
      exploreError: clearExploreError ? null : exploreError ?? this.exploreError,
      allUpcomingEvents: allUpcomingEvents ?? this.allUpcomingEvents,
      pastEvents: pastEvents ?? this.pastEvents,
      allEventsLoading: allEventsLoading ?? this.allEventsLoading,
      allEventsError:
          clearAllEventsError ? null : allEventsError ?? this.allEventsError,
      selectedCategoryId:
          clearCategory ? null : selectedCategoryId ?? this.selectedCategoryId,
      selectedCategoryName: clearCategory
          ? null
          : selectedCategoryName ?? this.selectedCategoryName,
      categoryEvents: clearCategory ? const [] : categoryEvents ?? this.categoryEvents,
      categoryEventsLoading:
          categoryEventsLoading ?? this.categoryEventsLoading,
      categoryEventsError: clearCategoryError
          ? null
          : categoryEventsError ?? this.categoryEventsError,
    );
  }

  @override
  List<Object?> get props => [
        classifications,
        upcomingEvents,
        nearbyEvents,
        exploreLoading,
        exploreError,
        allUpcomingEvents,
        pastEvents,
        allEventsLoading,
        allEventsError,
        selectedCategoryId,
        selectedCategoryName,
        categoryEvents,
        categoryEventsLoading,
        categoryEventsError,
      ];
}
