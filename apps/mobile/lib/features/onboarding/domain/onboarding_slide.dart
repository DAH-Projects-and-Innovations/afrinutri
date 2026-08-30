import 'package:flutter/material.dart';

class OnboardingSlide {
  const OnboardingSlide({
    required this.imagePath,
    required this.badgeIcon,
    required this.badgeLabel,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final IconData badgeIcon;
  final String badgeLabel;
  final String title;
  final String description;
}

const List<OnboardingSlide> onboardingSlides = [
  OnboardingSlide(
    imagePath: 'assets/images/onboarding/plats_preferes.webp',
    badgeIcon: Icons.public_outlined,
    badgeLabel: 'Cuisine africaine',
    title: 'Tes plats préférés, sous la loupe',
    description:
        "Thiéboudiène, mafé, alloco... AfriNutri reconnaît les recettes "
        "africaines et calcule leurs nutriments en quelques secondes.",
  ),
  OnboardingSlide(
    imagePath: 'assets/images/onboarding/prend_photo.jpg',
    badgeIcon: Icons.camera_alt_outlined,
    badgeLabel: 'Scanner instantané',
    title: "Prends une photo, obtiens l'analyse",
    description:
        "Pointe ton téléphone vers ton assiette. Notre IA identifie les "
        "ingrédients et t'affiche calories, protéines et glucides.",
  ),
  OnboardingSlide(
    imagePath: 'assets/images/onboarding/compte_caloris.jfif',
    badgeIcon: Icons.track_changes_outlined,
    badgeLabel: 'Objectif personnalisé',
    title: 'Un plan calorique rien que pour toi',
    description:
        "Renseigne ton âge, ta taille et ton activité. AfriNutri calcule "
        "ton objectif quotidien avec la formule Mifflin-St Jeor.",
  ),
  OnboardingSlide(
    imagePath: 'assets/images/onboarding/coach_nutri.jpg',
    badgeIcon: Icons.chat_bubble_outline,
    badgeLabel: 'Assistant IA',
    title: 'Ton coach nutrition personnel',
    description:
        "Pose tes questions à l'assistant AfriNutri : portions, fréquences, "
        "alternatives saines — des conseils pensés pour la cuisine locale.",
  ),
];
