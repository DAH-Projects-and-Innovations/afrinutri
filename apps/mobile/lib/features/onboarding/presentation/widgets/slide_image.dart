import 'package:flutter/material.dart';

import '../onboarding_palette.dart';

/// Displays the slide's photo with a bottom scrim for a smoother transition
/// into the content area, falling back to a plain gradient panel if the
/// asset can't be loaded.
class SlideImage extends StatelessWidget {
  const SlideImage({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const DecoratedBox(
              decoration: BoxDecoration(
                gradient: OnboardingPalette.primaryGradient,
              ),
              child: Center(
                child: Icon(Icons.restaurant, color: Colors.white, size: 56),
              ),
            );
          },
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 90,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black45],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
