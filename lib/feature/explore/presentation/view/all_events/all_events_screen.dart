import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import 'package:booking/core/constants.dart';
import 'package:booking/feature/explore/presentation/cubit/event/events_cubit.dart';
import 'package:booking/feature/explore/presentation/widgets/shimmer_widgets.dart';
import '../../cubit/event/events_state.dart';
import 'widget/all_event_card.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventsCubit>().fetchAllEvents(
          apiKey: AppConstants.apiKey,
          city: AppConstants.defaultCity,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Events',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
                color: AppColors.textPrimary, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert,
                color: AppColors.textPrimary, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          if (state is! EventsLoaded) {
            return const AllEventsShimmer();
          }

          if (state.allEventsLoading && state.allUpcomingEvents.isEmpty) {
            return const AllEventsShimmer();
          }

          if (state.allEventsError != null && state.allUpcomingEvents.isEmpty) {
            return Center(child: Text('Error: ${state.allEventsError}'));
          }

          final events = state.allUpcomingEvents;
          if (events.isEmpty) {
            return const Center(child: Text('No events found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return AllEventCard(event: events[index]);
            },
          );
        },
      ),
    );
  }
}
