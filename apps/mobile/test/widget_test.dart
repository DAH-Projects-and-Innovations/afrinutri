import 'package:flutter_test/flutter_test.dart';

import 'package:afrinutri/main.dart';

void main() {
  testWidgets('Onboarding flow smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // First slide is shown.
    expect(find.text('Tes plats préférés, sous la loupe'), findsOneWidget);

    // Tapping "Suivant" moves through the slides.
    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text("Prends une photo, obtiens l'analyse"), findsOneWidget);

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Un plan calorique rien que pour toi'), findsOneWidget);

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Ton coach nutrition personnel'), findsOneWidget);

    // Last slide finishes onboarding.
    await tester.tap(find.text('Commencer !'));
    await tester.pumpAndSettle();
    expect(find.text('Écrans d\'authentification à venir'), findsOneWidget);
  });
}
