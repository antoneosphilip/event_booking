import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import 'package:booking/feature/explore/presentation/view/event/widget/event_app_bar.dart';
import 'package:booking/feature/explore/presentation/view/widget/tab_bar.dart';
import 'package:booking/feature/explore/presentation/view/widget/empty_state.dart';
import 'package:booking/feature/explore/presentation/view/all_events/widget/all_event_card.dart';

import '../../cubit/events_cubit.dart';
import '../../cubit/events_state.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const EventsAppBar(),
            const SizedBox(height: 16),
            EventTabBar(
              selectedIndex: selectedTab,
              onTabChanged: (i) => setState(() => selectedTab = i)
            ),
            Expanded(
              child: BlocBuilder<EventsCubit, EventsState>(
                builder: (context, state) {
                  if (state is EventsLoading || state is EventsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EventsLoaded) {
                    final events = selectedTab == 0 ? state.allUpcomingEvents : state.pastEvents;

                    if (events.isEmpty) {
                      return const EmptyState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 20),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        final imageUrl = event.imageUrl.isNotEmpty ? event.imageUrl : 'assets/images/event_cover.png';
                        final location = event.venueName.isNotEmpty ? event.venueName : 'Unknown Location';

                        return AllEventCard(
                          title: event.name,
                          date: event.date,
                          location: location,
                          imagePath: imageUrl,
                        );
                      },
                    );
                  } else if (state is EventsError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
