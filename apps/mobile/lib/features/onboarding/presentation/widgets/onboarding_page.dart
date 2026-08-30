import 'package:flutter/material.dart';

import '../../domain/onboarding_slide.dart';
import '../onboarding_palette.dart';
import 'slide_badge.dart';
import 'slide_image.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Sized from the constraints this page actually receives (rather
        // than the full screen via MediaQuery) so it stays correct however
        // much space the parent PageView/Scaffold ends up allotting it.
        final imageHeight = constraints.maxHeight * 0.5;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: imageHeight,
              child: SlideImage(assetPath: slide.imagePath),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideBadge(
                      icon: slide.badgeIcon,
                      label: slide.badgeLabel,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      slide.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                        color: OnboardingPalette.titleColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      slide.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.45,
                        color: OnboardingPalette.descriptionColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
