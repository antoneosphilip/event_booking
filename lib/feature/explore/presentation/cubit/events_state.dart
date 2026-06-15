import 'package:equatable/equatable.dart';
import '../../data/models/classification_model.dart';
import '../../data/models/event_model.dart';

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
  
  // New fields for the all events screen
  final List<EventModel> allUpcomingEvents;
  final List<EventModel> pastEvents;

  const EventsLoaded({
    required this.classifications,
    required this.upcomingEvents,
    required this.nearbyEvents,
    this.allUpcomingEvents = const [],
    this.pastEvents = const [],
  });

  @override
  List<Object?> get props => [classifications, upcomingEvents, nearbyEvents, allUpcomingEvents, pastEvents];
}

class EventsError extends EventsState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object?> get props => [message];
}
