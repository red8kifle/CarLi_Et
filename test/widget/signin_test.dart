import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carli_et/features/auth/presentation/signin.dart';
import 'package:carli_et/features/home/presentation/home_screen.dart';

void main() {
  group('Signin Page Tests', () {
    testWidgets('Signin page displays email and password fields', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Signin(role: 'student')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Signin page has Forgot password link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Signin(role: 'student')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('Signin page has Go Back button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Signin(role: 'student')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Go Back'), findsOneWidget);
    });
  });

  group('Home Page Tests', () {
    testWidgets('Home page displays app title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: Home())),
      );

      await tester.pumpAndSettle();

      expect(find.text('CarLi_Et'), findsOneWidget);
      expect(find.text('Student Sign in'), findsOneWidget);
      expect(find.text('Company Sign in'), findsOneWidget);
    });

    testWidgets('Home page has Browse as Guest link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: Home())),
      );

      await tester.pumpAndSettle();

      expect(find.text('Browse as Guest'), findsOneWidget);
    });
  });
}
