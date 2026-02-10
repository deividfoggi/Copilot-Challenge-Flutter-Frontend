import 'package:flutter_test/flutter_test.dart';
import 'package:contoso_tracking/features/auth/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    const testUser = UserModel(
      id: 'test-001',
      name: 'Test User',
      email: 'test@contoso.domain',
      role: 'Administrator',
      regionalUnit: 'CAMPINAS OESTE',
    );

    const testUserWithoutRegional = UserModel(
      id: 'test-002',
      name: 'Viewer User',
      email: 'viewer@contoso.domain',
      role: 'Viewer',
    );

    test('should create UserModel with all fields', () {
      expect(testUser.id, 'test-001');
      expect(testUser.name, 'Test User');
      expect(testUser.email, 'test@contoso.domain');
      expect(testUser.role, 'Administrator');
      expect(testUser.regionalUnit, 'CAMPINAS OESTE');
    });

    test('should create UserModel without optional regionalUnit', () {
      expect(testUserWithoutRegional.id, 'test-002');
      expect(testUserWithoutRegional.regionalUnit, isNull);
    });

    test('should serialize to JSON correctly', () {
      final jsonMap = testUser.toJson();
      expect(jsonMap['id'], 'test-001');
      expect(jsonMap['name'], 'Test User');
      expect(jsonMap['email'], 'test@contoso.domain');
      expect(jsonMap['role'], 'Administrator');
      expect(jsonMap['regional_unit'], 'CAMPINAS OESTE');
    });

    test('should deserialize from JSON correctly', () {
      final jsonMap = {
        'id': 'test-003',
        'name': 'From JSON',
        'email': 'json@contoso.domain',
        'role': 'Regional Manager',
        'regional_unit': 'BAURU',
      };

      final user = UserModel.fromJson(jsonMap);
      expect(user.id, 'test-003');
      expect(user.name, 'From JSON');
      expect(user.email, 'json@contoso.domain');
      expect(user.role, 'Regional Manager');
      expect(user.regionalUnit, 'BAURU');
    });

    test('should roundtrip JSON serialization', () {
      final jsonString = testUser.toJsonString();
      final deserialized = UserModel.fromJsonString(jsonString);
      expect(deserialized, testUser);
    });

    test('should support equality', () {
      const user1 = UserModel(
        id: 'same-id',
        name: 'Same Name',
        email: 'same@email.com',
        role: 'Viewer',
      );
      const user2 = UserModel(
        id: 'same-id',
        name: 'Same Name',
        email: 'same@email.com',
        role: 'Viewer',
      );
      expect(user1, user2);
    });

    test('should detect inequality', () {
      const user1 = UserModel(
        id: 'id-1',
        name: 'Name',
        email: 'email@test.com',
        role: 'Viewer',
      );
      const user2 = UserModel(
        id: 'id-2',
        name: 'Name',
        email: 'email@test.com',
        role: 'Viewer',
      );
      expect(user1, isNot(user2));
    });

    test('should support copyWith', () {
      final updated = testUser.copyWith(name: 'Updated Name');
      expect(updated.name, 'Updated Name');
      expect(updated.id, testUser.id);
      expect(updated.email, testUser.email);
    });

    test('should have meaningful toString', () {
      final str = testUser.toString();
      expect(str, contains('test-001'));
      expect(str, contains('Test User'));
    });
  });
}
