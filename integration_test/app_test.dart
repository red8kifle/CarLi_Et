import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carli_et/app/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('App launches successfully', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('CarLi_Et'), findsOneWidget);
      expect(find.text('Student Sign in'), findsOneWidget);
      expect(find.text('Company Sign in'), findsOneWidget);
      expect(find.text('Browse as Guest'), findsOneWidget);
    });

    testWidgets('Home page has all buttons', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Student Sign in'), findsOneWidget);
      expect(find.text('Company Sign in'), findsOneWidget);
      expect(find.text('Browse as Guest'), findsOneWidget);
    });
  });
}
