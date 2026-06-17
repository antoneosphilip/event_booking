import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/service_locator.dart';
import 'core/network/dio_helper.dart';
import 'core/preferences/app_preferences.dart';
import 'feature/explore/presentation/view/onBoarding/onboarding_screen.dart';
import 'feature/explore/presentation/view/home/home_layout.dart';
import 'feature/explore/presentation/cubit/auth/auth_cubit.dart';
import 'feature/explore/presentation/cubit/favorites/favorites_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await setupServiceLocator();
  
  final appPreferences = sl<AppPreferences>();
  final isLoggedIn = appPreferences.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()..loadSession()),
        BlocProvider(create: (context) => sl<FavoritesCubit>()..loadFavorites()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white
        ),
        home: isLoggedIn ? const HomeLayout() : const OnboardingScreen(),
      ),
    );
  }
}
