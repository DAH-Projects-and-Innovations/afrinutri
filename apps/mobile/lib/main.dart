import 'package:flutter/material.dart';

import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AfriNutri',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) => OnboardingScreen(
          onFinished: () {
            // TODO(auth): remplacer par la navigation vers l'écran de login
            // une fois les écrans d'authentification de Gaston (Issue #8) et
            // le app_router (Issue #7) disponibles sur la branche.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const _AuthPlaceholderScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AuthPlaceholderScreen extends StatelessWidget {
  const _AuthPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Écrans d\'authentification à venir')),
    );
  }
}
