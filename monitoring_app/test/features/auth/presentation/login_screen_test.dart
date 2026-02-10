import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contoso_tracking/core/config/environment.dart';
import 'package:contoso_tracking/features/auth/presentation/login_screen.dart';

void main() {
  setUp(() {
    Environment.setEnvironment(AppEnvironment.dev);
  });

  Widget createLoginScreen() {
    return const ProviderScope(
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen', () {
    testWidgets('should display Contoso title', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('Contoso'), findsOneWidget);
      expect(find.text('Sistema de Monitoramento'), findsOneWidget);
    });

    testWidgets('should display email and password fields', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
    });

    testWidgets('should display login button', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('ENTRAR'), findsOneWidget);
    });

    testWidgets('should validate empty email', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Tap login button without entering anything
      await tester.tap(find.text('ENTRAR'));
      await tester.pumpAndSettle();

      expect(find.text('Email é obrigatório'), findsOneWidget);
    });

    testWidgets('should validate invalid email', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Enter invalid email
      await tester.enterText(
        find.byType(TextFormField).first,
        'invalid-email',
      );
      await tester.tap(find.text('ENTRAR'));
      await tester.pumpAndSettle();

      expect(find.text('Email inválido'), findsOneWidget);
    });

    testWidgets('should validate empty password', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Enter valid email but no password
      await tester.enterText(
        find.byType(TextFormField).first,
        'test@contoso.domain',
      );
      await tester.tap(find.text('ENTRAR'));
      await tester.pumpAndSettle();

      expect(find.text('Senha é obrigatória'), findsOneWidget);
    });

    testWidgets('should validate short password', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Enter valid email and short password
      await tester.enterText(
        find.byType(TextFormField).first,
        'test@contoso.domain',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        '12345',
      );
      await tester.tap(find.text('ENTRAR'));
      await tester.pumpAndSettle();

      expect(
        find.text('Senha deve ter no mínimo 6 caracteres'),
        findsOneWidget,
      );
    });

    testWidgets('should toggle password visibility', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find the visibility toggle button
      final visibilityButton = find.byIcon(Icons.visibility);
      expect(visibilityButton, findsOneWidget);

      // Toggle visibility
      await tester.tap(visibilityButton);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should show test credentials info', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('Acesso de teste (MVP)'), findsOneWidget);
    });

    testWidgets('should have ENTRAR button enabled initially', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find the ElevatedButton with ENTRAR text
      final button = find.widgetWithText(ElevatedButton, 'ENTRAR');
      expect(button, findsOneWidget);

      final elevatedButton = tester.widget<ElevatedButton>(button);
      expect(elevatedButton.onPressed, isNotNull);
    });
  });
}
