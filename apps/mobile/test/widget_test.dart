import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:afrinutri/main.dart';

void main() {
  testWidgets('Onboarding flow smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // First slide is shown.
    expect(find.text('Suivez votre alimentation'), findsOneWidget);

    // Tapping "Suivant" moves to the next slide.
    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Analysez vos repas par IA'), findsOneWidget);

    // Advance to the last slide and finish onboarding.
    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Atteignez vos objectifs'), findsOneWidget);

    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();
    expect(find.text('Écrans d\'authentification à venir'), findsOneWidget);
  });
}
