import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/events_repository.dart';
import 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final EventsRepository repository;

  EventDetailsCubit(this.repository) : super(EventDetailsInitial());

  static EventDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchEventDetails(String apiKey, String eventId) async {
    emit(EventDetailsLoading());
    try {
      final details = await repository.getEventDetails(apiKey, eventId);
      emit(EventDetailsLoaded(details));
    } catch (e) {
      emit(EventDetailsError(e.toString()));
    }
  }
}
