import 'package:booking/view/sign_in.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class OnboardingPage {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = const [
    OnboardingPage(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Explore Upcoming and\nNearby Events',
      description: 'In publishing and graphic design, Lorem is\na placeholder text commonly',
    ),
    OnboardingPage(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'We Have Modern Events\nCalendar Feature',
      description: 'In publishing and graphic design, Lorem is\na placeholder text commonly',
    ),
    OnboardingPage(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'To Look Up More Events or\nActivities Nearby By Map',
      description: 'In publishing and graphic design, Lorem is\na placeholder text commonly',
    ),
  ];

  void _goNext() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: Image.asset(
                _pages[i].imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomCard(
              title: _pages[_currentPage].title,
              description: _pages[_currentPage].description,
              currentPage: _currentPage,
              totalPages: _pages.length,
              onSkip: _skip,
              onNext: _goNext,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomCard extends StatelessWidget {
  final String title;
  final String description;
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const _BottomCard({
    required this.title,
    required this.description,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textOnPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textOnPrimary.withOpacity(0.75),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SkipButton(onTap: onSkip),
              _PageIndicator(current: currentPage, total: totalPages),
              _NextButton(onTap: onNext, isLast: currentPage == totalPages - 1),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SkipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Skip',
        style: TextStyle(
          color: AppColors.textOnPrimary.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLast;
  const _NextButton({required this.onTap, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        isLast ? 'Get Started' : 'Next',
        style: const TextStyle(
          color: AppColors.textOnPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int current;
  final int total;
  const _PageIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == current;
        return Container(
          width: isActive ? 20 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isActive ? AppColors.dotActive : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

