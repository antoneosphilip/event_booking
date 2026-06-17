import 'dart:async';

import 'package:booking/feature/explore/presentation/cubit/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/events_repository.dart';

class SearchCubit extends Cubit<SearchState> {
  final EventsRepository repository;

  SearchCubit(this.repository) : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  Timer? _debounce;
  void searchEvents(String apiKey, String keyword) {
    _debounce?.cancel();

    if (keyword.isEmpty) {
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchLoading());

      try {
        final events = await repository.searchEvents(apiKey, keyword);
        emit(SearchLoaded(events));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
