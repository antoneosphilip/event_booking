import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'core/network/dio_helper.dart';
import 'feature/explore/presentation/view/onBoarding/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white
      ),
      home: const OnboardingScreen(),
    );
  }
}
