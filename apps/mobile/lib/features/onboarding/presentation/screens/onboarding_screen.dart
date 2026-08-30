import 'package:flutter/material.dart';

import '../../domain/onboarding_slide.dart';
import '../widgets/floating_pill.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indicator.dart';
import '../widgets/primary_gradient_button.dart';

/// First screen shown to a new user: presents the app's value proposition
/// as a set of swipeable slides before handing off to auth ([onFinished]).
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;

  bool get _isLastSlide => _currentIndex == onboardingSlides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextSlide() {
    if (_isLastSlide) {
      widget.onFinished();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingSlides.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  child: OnboardingPage(slide: onboardingSlides[index]),
                  builder: (context, child) {
                    var page = index.toDouble();
                    if (_pageController.hasClients &&
                        _pageController.position.haveDimensions) {
                      page = _pageController.page ?? page;
                    }
                    final opacity = (1 - (page - index).abs()).clamp(0.0, 1.0);
                    return Opacity(opacity: opacity, child: child);
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingPill(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/images/logo.jfif',
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'AfriNutri',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PageIndicator(
                count: onboardingSlides.length,
                currentIndex: _currentIndex,
              ),
              const SizedBox(height: 20),
              PrimaryGradientButton(
                label: _isLastSlide ? 'Commencer !' : 'Suivant',
                onPressed: _goToNextSlide,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
