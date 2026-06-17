import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import 'package:booking/core/constants.dart';
import 'package:booking/feature/explore/presentation/cubit/search/search_cubit.dart';
import '../../../../../core/service_locator.dart';
import '../../cubit/search/search_state.dart';
import 'widget/search_bar_widget.dart';
import 'widget/search_event_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Search',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Builder(
          builder: (innerContext) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SearchBarWidget(
                    controller: _searchController,
                    onChanged: (value) {
                      innerContext.read<SearchCubit>().searchEvents(
                        AppConstants.apiKey,
                        value,
                      );
                    },
                    onSubmitted: (value) {
                      innerContext.read<SearchCubit>().searchEvents(
                            AppConstants.apiKey,
                            value,
                          );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return const Center(
                          child: Text(
                            'Type to search for events',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        );
                      }

                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary),
                        );
                      }

                      if (state is SearchError) {
                        return Center(
                          child: Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state is SearchLoaded) {
                        final events = state.events;

                        if (events.isEmpty) {
                          return const Center(
                            child: Text(
                              'No events found',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            return SearchEventCard(event: events[index]);
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
