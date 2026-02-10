import 'package:flutter_test/flutter_test.dart';
import 'package:contoso_tracking/core/config/environment.dart';

void main() {
  group('Environment', () {
    setUp(() {
      // Reset to dev for each test
      Environment.setEnvironment(AppEnvironment.dev);
    });

    test('should default to dev environment', () {
      expect(Environment.environment, AppEnvironment.dev);
      expect(Environment.isDev, isTrue);
      expect(Environment.isProd, isFalse);
    });

    test('should switch to prod environment', () {
      Environment.setEnvironment(AppEnvironment.prod);

      expect(Environment.environment, AppEnvironment.prod);
      expect(Environment.isDev, isFalse);
      expect(Environment.isProd, isTrue);
    });

    test('should return correct API base URL for dev', () {
      Environment.setEnvironment(AppEnvironment.dev);
      expect(Environment.apiBaseUrl, contains('api-dev'));
    });

    test('should return correct API base URL for prod', () {
      Environment.setEnvironment(AppEnvironment.prod);
      expect(Environment.apiBaseUrl, isNot(contains('api-dev')));
    });

    test('should enable logs in dev only', () {
      Environment.setEnvironment(AppEnvironment.dev);
      expect(Environment.enableLogs, isTrue);

      Environment.setEnvironment(AppEnvironment.prod);
      expect(Environment.enableLogs, isFalse);
    });

    test('should have correct environment names', () {
      Environment.setEnvironment(AppEnvironment.dev);
      expect(Environment.environmentName, 'Desenvolvimento');

      Environment.setEnvironment(AppEnvironment.prod);
      expect(Environment.environmentName, 'Produção');
    });

    test('should have timeout and refresh values', () {
      expect(Environment.timeoutSeconds, greaterThan(0));
      expect(Environment.dashboardRefreshInterval, greaterThan(0));
    });

    test('should have API version', () {
      expect(Environment.apiVersion, isNotEmpty);
    });
  });
}
