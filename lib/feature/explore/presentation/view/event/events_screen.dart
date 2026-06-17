import 'package:booking/feature/explore/presentation/view/event/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import 'package:booking/core/constants.dart';
import 'package:booking/feature/explore/presentation/view/event/widget/event_app_bar.dart';
import 'package:booking/feature/explore/presentation/view/widget/tab_bar.dart';
import 'package:booking/feature/explore/presentation/view/widget/empty_state.dart';
import 'package:booking/feature/explore/presentation/view/all_events/widget/all_event_card.dart';
import 'package:booking/feature/explore/presentation/widgets/shimmer_widgets.dart';

import '../../cubit/event/events_cubit.dart';
import '../../cubit/event/events_state.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  int selectedTab = 0;
  bool _allEventsRequested = false;

  void _ensureAllEventsLoaded() {
    if (_allEventsRequested) return;
    _allEventsRequested = true;
    context.read<EventsCubit>().fetchAllEvents(
          apiKey: AppConstants.apiKey,
          city: AppConstants.defaultCity,
        );
  }

  void _onTabChanged(int index) {
    setState(() => selectedTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state is EventsLoaded && state.selectedCategoryId != null) {
          return _buildCategoryView(context, state);
        }

        _ensureAllEventsLoaded();
        return _buildAllEventsView(context, state);
      },
    );
  }

  Widget _buildCategoryView(BuildContext context, EventsLoaded state) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textPrimary),
                    onPressed: () =>
                        context.read<EventsCubit>().clearCategoryFilter(),
                  ),
                  Expanded(
                    child: Text(
                      state.selectedCategoryName ?? 'Category',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildCategoryEventsList(state)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryEventsList(EventsLoaded state) {
    if (state.categoryEventsLoading && state.categoryEvents.isEmpty) {
      return const AllEventsShimmer();
    }

    if (state.categoryEventsError != null && state.categoryEvents.isEmpty) {
      return Center(
        child: Text(
          'Error: ${state.categoryEventsError}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state.categoryEvents.isEmpty) {
      return const EmptyState();
    }

    return ListView.builder(
      itemCount: state.categoryEvents.length,
      itemBuilder: (_, index) {
        final event = state.categoryEvents[index];
        return AllEventCard(
          event: event,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(eventId: event.id),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAllEventsView(BuildContext context, EventsState state) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const EventsAppBar(),
            const SizedBox(height: 16),
            EventTabBar(
              selectedIndex: selectedTab,
              onTabChanged: _onTabChanged,
            ),
            Expanded(
              child: BlocBuilder<EventsCubit, EventsState>(
                buildWhen: (previous, current) {
                  if (current is! EventsLoaded) return true;
                  if (previous is! EventsLoaded) return true;
                  return previous.allEventsLoading != current.allEventsLoading ||
                      previous.allEventsError != current.allEventsError ||
                      previous.allUpcomingEvents != current.allUpcomingEvents ||
                      previous.pastEvents != current.pastEvents;
                },
                builder: (context, state) {
                  if (state is! EventsLoaded) {
                    return const AllEventsShimmer();
                  }

                  if (state.allEventsLoading && state.allUpcomingEvents.isEmpty) {
                    return const AllEventsShimmer();
                  }

                  if (state.allEventsError != null &&
                      state.allUpcomingEvents.isEmpty &&
                      state.pastEvents.isEmpty) {
                    return Center(
                      child: Text(
                        'Error: ${state.allEventsError}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final events = selectedTab == 0
                      ? state.allUpcomingEvents
                      : state.pastEvents;

                  if (events.isEmpty) {
                    return const EmptyState();
                  }

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (_, index) {
                      return AllEventCard(
                        event: events[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailsScreen(eventId: events[index].id),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
