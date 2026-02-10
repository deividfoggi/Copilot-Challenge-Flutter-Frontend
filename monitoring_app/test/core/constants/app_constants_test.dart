import 'package:flutter_test/flutter_test.dart';
import 'package:contoso_tracking/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('should have valid app info', () {
      expect(AppConstants.appName, isNotEmpty);
      expect(AppConstants.appVersion, isNotEmpty);
    });

    test('should have storage keys defined', () {
      expect(AppConstants.accessTokenKey, isNotEmpty);
      expect(AppConstants.refreshTokenKey, isNotEmpty);
      expect(AppConstants.userDataKey, isNotEmpty);
      expect(AppConstants.lastLoginKey, isNotEmpty);
    });

    test('should have API endpoints defined', () {
      expect(AppConstants.authEndpoint, isNotEmpty);
      expect(AppConstants.refreshEndpoint, isNotEmpty);
      expect(AppConstants.logoutEndpoint, isNotEmpty);
      expect(AppConstants.dashboardEndpoint, isNotEmpty);
    });

    test('should have valid timeout values', () {
      expect(AppConstants.connectTimeout, greaterThan(0));
      expect(AppConstants.receiveTimeout, greaterThan(0));
      expect(AppConstants.sendTimeout, greaterThan(0));
    });

    test('should have valid refresh intervals', () {
      expect(AppConstants.dashboardRefreshSeconds, greaterThan(0));
      expect(AppConstants.alertsRefreshSeconds, greaterThan(0));
    });

    test('should have valid pagination defaults', () {
      expect(AppConstants.defaultPageSize, greaterThan(0));
      expect(AppConstants.maxPageSize, greaterThan(AppConstants.defaultPageSize));
    });

    test('should have alert types defined', () {
      expect(AppConstants.alertRoteador, isNotEmpty);
      expect(AppConstants.alertFirewall, isNotEmpty);
      expect(AppConstants.alertSdwan, isNotEmpty);
      expect(AppConstants.alertStarlink, isNotEmpty);
    });

    test('should have regional units list', () {
      expect(AppConstants.regionalUnits, isNotEmpty);
      expect(AppConstants.regionalUnits.length, greaterThan(10));
    });

    test('should have mock credentials for MVP', () {
      expect(AppConstants.mockUsername, contains('@'));
      expect(AppConstants.mockPassword, isNotEmpty);
    });
  });
}
