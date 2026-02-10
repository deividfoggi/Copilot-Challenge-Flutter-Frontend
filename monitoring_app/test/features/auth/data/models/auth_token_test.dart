import 'package:flutter_test/flutter_test.dart';
import 'package:contoso_tracking/features/auth/data/models/auth_token.dart';

void main() {
  group('AuthToken', () {
    test('should create AuthToken with all fields', () {
      final token = AuthToken(
        accessToken: 'access-123',
        refreshToken: 'refresh-456',
        expiresAt: DateTime(2026, 12, 31),
        tokenType: 'Bearer',
      );

      expect(token.accessToken, 'access-123');
      expect(token.refreshToken, 'refresh-456');
      expect(token.tokenType, 'Bearer');
    });

    test('should detect expired token', () {
      final expiredToken = AuthToken(
        accessToken: 'expired-token',
        refreshToken: 'refresh',
        expiresAt: DateTime(2020, 1, 1), // Passado
        tokenType: 'Bearer',
      );

      expect(expiredToken.isExpired, isTrue);
    });

    test('should detect valid token', () {
      final validToken = AuthToken(
        accessToken: 'valid-token',
        refreshToken: 'refresh',
        expiresAt: DateTime(2030, 12, 31), // Futuro
        tokenType: 'Bearer',
      );

      expect(validToken.isExpired, isFalse);
    });

    test('should calculate minutes until expiration', () {
      final futureToken = AuthToken(
        accessToken: 'token',
        refreshToken: 'refresh',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        tokenType: 'Bearer',
      );

      expect(futureToken.minutesUntilExpiration, greaterThanOrEqualTo(59));
    });

    test('should serialize to JSON correctly', () {
      final token = AuthToken(
        accessToken: 'access-123',
        refreshToken: 'refresh-456',
        expiresAt: DateTime(2026, 6, 15, 10, 30),
        tokenType: 'Bearer',
      );

      final jsonMap = token.toJson();
      expect(jsonMap['access_token'], 'access-123');
      expect(jsonMap['refresh_token'], 'refresh-456');
      expect(jsonMap['token_type'], 'Bearer');
      expect(jsonMap['expires_at'], isNotNull);
    });

    test('should deserialize from JSON correctly', () {
      final jsonMap = {
        'access_token': 'access-789',
        'refresh_token': 'refresh-012',
        'expires_at': '2026-06-15T10:30:00.000',
        'token_type': 'Bearer',
      };

      final token = AuthToken.fromJson(jsonMap);
      expect(token.accessToken, 'access-789');
      expect(token.refreshToken, 'refresh-012');
      expect(token.tokenType, 'Bearer');
    });

    test('should roundtrip JSON serialization', () {
      final original = AuthToken(
        accessToken: 'round-trip',
        refreshToken: 'refresh-trip',
        expiresAt: DateTime(2026, 6, 15, 10, 30),
        tokenType: 'Bearer',
      );

      final jsonString = original.toJsonString();
      final restored = AuthToken.fromJsonString(jsonString);

      expect(restored.accessToken, original.accessToken);
      expect(restored.refreshToken, original.refreshToken);
      expect(restored.tokenType, original.tokenType);
    });
  });
}
