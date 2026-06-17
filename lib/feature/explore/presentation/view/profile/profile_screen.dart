import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import '../../cubit/auth/auth_cubit.dart';
import 'widget/about_tab.dart';
import 'widget/favorite_tab.dart';
import 'widget/profile_action_buttons.dart';
import 'widget/profile_header.dart';
import 'widget/profile_stats.dart';
import 'widget/profile_tab_bar.dart';
import 'widget/reviews_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is! AuthSuccess) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = state.user;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
                onPressed: () {},
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                ProfileHeader(name: user.name, email: user.email),
                const SizedBox(height: 24),
                const ProfileStats(),
                const SizedBox(height: 24),
                const ProfileActionButtons(),
                const SizedBox(height: 32),
                ProfileTabBar(
                  selectedIndex: selectedTab,
                  onTabChanged: (index) => setState(() => selectedTab = index),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildTabContent(user.name, user.email),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabContent(String name, String email) {
    switch (selectedTab) {
      case 0:
        return AboutTab(name: name, email: email);
      case 1:
        return const FavoriteTab();
      case 2:
      default:
        return const ReviewsTab();
    }
  }
}
