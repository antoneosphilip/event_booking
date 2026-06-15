import 'package:equatable/equatable.dart';

import '../../../data/models/classification_model.dart';
import '../../../data/models/event_model.dart';


abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<ClassificationModel> classifications;
  final List<EventModel> upcomingEvents;
  final List<EventModel> nearbyEvents;

  const EventsLoaded({
    required this.classifications,
    required this.upcomingEvents,
    required this.nearbyEvents,
  });

  @override
  List<Object?> get props => [
    classifications,
    upcomingEvents,
    nearbyEvents,
  ];
}

class EventsError extends EventsState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object?> get props => [message];
}


class AllEventsLoading extends EventsState {}

class AllEventsLoaded extends EventsState {
  final List<EventModel> upcomingEvents;
  final List<EventModel> pastEvents;

  const AllEventsLoaded({
    required this.upcomingEvents,
    required this.pastEvents,
  });

  @override
  List<Object?> get props => [
    upcomingEvents,
    pastEvents,
  ];
}

class AllEventsError extends EventsState {
  final String message;

  const AllEventsError(this.message);

  @override
  List<Object?> get props => [message];
}