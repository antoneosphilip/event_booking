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

import '../../../data/models/event_model.dart';
import '../../cubit/event/events_cubit.dart';
import '../../cubit/event/events_state.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  int selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    context.read<EventsCubit>().fetchAllEvents(
      apiKey: AppConstants.apiKey,
      city: AppConstants.defaultCity,
    );
    super.initState();
  }
  void _onTabChanged(int index) {
    setState(() => selectedTab = index);

  }

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
              onTabChanged: _onTabChanged,
            ),
            Expanded(
              child: BlocBuilder<EventsCubit, EventsState>(
                buildWhen: (previous, current) => current is AllEventsLoading || current is AllEventsError|| current is AllEventsLoaded ,
                builder: (context, state) {
                  if (state is AllEventsLoading) {
                    return const AllEventsShimmer();
                  }

                  if (state is AllEventsError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is AllEventsLoaded) {
                    final events = selectedTab == 0
                        ? state.upcomingEvents
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsScreen(eventId: events[index].id),));
                          },
                        );
                      },
                    );
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
