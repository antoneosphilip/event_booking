import 'package:booking/feature/explore/presentation/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import 'package:booking/core/constants.dart';
import 'package:booking/feature/explore/presentation/cubit/event_details/event_details_cubit.dart';
import 'package:booking/feature/explore/presentation/view/event/widget/event_appbar.dart';
import 'package:booking/feature/explore/presentation/view/widget/about_section.dart';
import 'package:booking/feature/explore/presentation/view/widget/buy_tecket_button.dart';
import 'package:booking/feature/explore/presentation/view/event/widget/event_title.dart';
import 'package:booking/feature/explore/presentation/view/widget/info_title.dart';
import 'package:booking/feature/explore/presentation/view/widget/organize_title.dart';
import '../../../../../core/service_locator.dart';
import '../../cubit/event_details/event_details_state.dart';

class EventDetailsScreen extends StatelessWidget {
  final String eventId;

  const EventDetailsScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventDetailsCubit>()..fetchEventDetails(AppConstants.apiKey, eventId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<EventDetailsCubit, EventDetailsState>(
          builder: (context, state) {
            if (state is EventDetailsLoading) {
              return const Center(child: Column(
                children: [
                  SizedBox(height: 100),
                  NearbyEventsShimmer(),
                ],
              ));
            }

            if (state is EventDetailsError) {
              return Center(
                child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)),
              );
            }

            if (state is EventDetailsLoaded) {
              final event = state.eventDetails;

              String dateSubtitle = '';
              if (event.localDate.isNotEmpty) {
                dateSubtitle = event.localDate;
                if (event.localTime.isNotEmpty) {
                  dateSubtitle += ' • ${event.localTime}';
                }
              } else {
                dateSubtitle = 'TBD';
              }

              String venueSubtitle = '';
              if (event.venueAddress.isNotEmpty) {
                venueSubtitle = event.venueAddress;
                if (event.venueCity.isNotEmpty) {
                  venueSubtitle += ', ${event.venueCity}';
                }
              } else {
                venueSubtitle = 'Location TBD';
              }

              String priceStr = '\$120';
              if (event.minPrice > 0) {
                priceStr = '${event.minPrice} ${event.currency}';
                if (event.maxPrice > event.minPrice) {
                  priceStr += ' - ${event.maxPrice}';
                }
              }

              String coverImage = event.images.isNotEmpty ? event.images.first : '';

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EventAppBar(imageUrl: coverImage),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              EventTitle(title: event.name),
                              const SizedBox(height: 20),
                              InfoTile(
                                icon: Icons.calendar_today_outlined,
                                title: 'Date & Time',
                                subtitle: dateSubtitle,
                              ),
                              const SizedBox(height: 12),
                              InfoTile(
                                icon: Icons.location_on_outlined,
                                title: event.venueName.isNotEmpty ? event.venueName : 'Venue',
                                subtitle: venueSubtitle,
                              ),
                              const SizedBox(height: 12),
                              if (event.organizerName.isNotEmpty) ...[
                                OrganizerTile(
                                  name: event.organizerName,
                                  role: 'Organizer',
                                  imagePath: event.organizerImageUrl.isNotEmpty
                                      ? event.organizerImageUrl
                                      : 'assets/images/organizer.png',
                                ),
                                const SizedBox(height: 24),
                              ],
                              AboutSection(
                                text: event.info.isNotEmpty 
                                  ? event.info 
                                  : (event.pleaseNote.isNotEmpty ? event.pleaseNote : 'No description available for this event.'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BuyTicketButton(price: priceStr),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
