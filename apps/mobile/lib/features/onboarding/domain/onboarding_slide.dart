import 'package:flutter/material.dart';

class OnboardingSlide {
  const OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

const List<OnboardingSlide> onboardingSlides = [
  OnboardingSlide(
    icon: Icons.restaurant_menu,
    title: 'Suivez votre alimentation',
    description:
        "Enregistrez vos repas au quotidien et gardez une vue claire "
        "sur ce que vous mangez.",
  ),
  OnboardingSlide(
    icon: Icons.camera_alt_outlined,
    title: 'Analysez vos repas par IA',
    description:
        "Prenez une photo de votre plat : AfriNutri reconnaît les aliments "
        "et calcule leurs valeurs nutritionnelles.",
  ),
  OnboardingSlide(
    icon: Icons.emoji_events_outlined,
    title: 'Atteignez vos objectifs',
    description:
        "Des recommandations adaptées à vos besoins pour progresser "
        "vers une alimentation équilibrée.",
  ),
];
