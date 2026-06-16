import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';
import '../event/events_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../core/constants.dart';
import '../../cubit/event/events_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeScreen(onDrawerTap: () => _scaffoldKey.currentState?.openDrawer()),
      const EventsScreen(),
      const Center(child: Icon(Icons.map_outlined, size: 48, color: AppColors.primary)),
      const ProfileScreen(),
    ];

  }

  void _onTabTapped(BuildContext innerContext, int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventsCubit>()
        ..fetchExploreData(
          apiKey: AppConstants.apiKey,
          city: AppConstants.defaultCity,
          latlong: AppConstants.defaultLatlong,
        ),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.background,
            drawer: const Drawer(),
            body: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.primary,
              elevation: 6,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              elevation: 12,
              notchMargin: 8,
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(innerContext, Icons.explore_outlined, 'Explore', 0),
                    _buildNavItem(innerContext, Icons.event_outlined, 'Events', 1),
                    const SizedBox(width: 48),
                    _buildNavItem(innerContext, Icons.map_outlined, 'Map', 2),
                    _buildNavItem(innerContext, Icons.person_outline, 'Profile', 3),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(BuildContext innerContext, IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(innerContext, index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
