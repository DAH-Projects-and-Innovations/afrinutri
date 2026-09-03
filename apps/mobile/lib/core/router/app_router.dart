// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/landing_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../network/api_client.dart';

class AppRoutes {
  static const onboarding = '/onboarding';
  static const landing = '/landing';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const scan = '/scan';
  static const result = '/result';
  static const assistant = '/assistant';
  static const profile = '/profile';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  redirect: (context, state) async {
    // Si déjà connecté → aller directement à l'accueil
    final isLoggedIn = await apiClient.hasToken();
    final isOnAuth =
        state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register ||
        state.matchedLocation == AppRoutes.landing ||
        state.matchedLocation == AppRoutes.onboarding;

    if (isLoggedIn && isOnAuth) return AppRoutes.home;
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(path: AppRoutes.landing, builder: (_, __) => const LandingScreen()),
    GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
    GoRoute(
      path: AppRoutes.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(path: AppRoutes.home, builder: (_, __) => const HomeScreen()),
  ],
);
