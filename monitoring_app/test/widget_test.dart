import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contoso_tracking/core/config/environment.dart';
import 'package:contoso_tracking/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Define ambiente de teste
    Environment.setEnvironment(AppEnvironment.dev);

    // Build app
    await tester.pumpWidget(
      const ProviderScope(
        child: ContosoTrackingApp(),
      ),
    );

    // Verifica que a tela de login é exibida
    expect(find.text('Contoso'), findsOneWidget);
  });
}
