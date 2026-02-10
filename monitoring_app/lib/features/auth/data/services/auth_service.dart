import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:contoso_tracking/core/constants/app_constants.dart';
import 'package:contoso_tracking/features/auth/data/models/auth_token.dart';
import 'package:contoso_tracking/features/auth/data/models/user_model.dart';

/// Exceção de autenticação
class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Serviço de autenticação mock para MVP
class AuthService {
  AuthService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  /// Realiza login (mock - aceita qualquer credencial válida)
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    // Simula delay de rede
    await Future.delayed(const Duration(seconds: 1));

    // Validações básicas
    if (username.isEmpty || password.isEmpty) {
      throw AuthException('Usuário e senha são obrigatórios');
    }

    if (!username.contains('@')) {
      throw AuthException('Email inválido');
    }

    if (password.length < 6) {
      throw AuthException('Senha deve ter no mínimo 6 caracteres');
    }

    // Mock: Simula diferentes perfis baseado no email
    final UserModel user;
    if (username.contains('regional')) {
      user = UserModel(
        id: _generateId(),
        name: _extractNameFromEmail(username),
        email: username,
        role: 'Regional Manager',
        regionalUnit: 'CAMPINAS OESTE',
      );
    } else if (username.contains('admin')) {
      user = const UserModel(
        id: 'admin-001',
        name: 'Administrador Contoso',
        email: 'admin@contoso.domain',
        role: 'Administrator',
      );
    } else {
      user = UserModel(
        id: _generateId(),
        name: _extractNameFromEmail(username),
        email: username,
        role: 'Viewer',
      );
    }

    // Gera tokens mock
    final token = _generateMockToken();

    // Armazena dados de forma segura
    await _secureStorage.write(
      key: AppConstants.accessTokenKey,
      value: token.accessToken,
    );
    await _secureStorage.write(
      key: AppConstants.refreshTokenKey,
      value: token.refreshToken,
    );
    await _secureStorage.write(
      key: AppConstants.userDataKey,
      value: user.toJsonString(),
    );
    await _secureStorage.write(
      key: AppConstants.lastLoginKey,
      value: DateTime.now().toIso8601String(),
    );

    return user;
  }

  /// Realiza logout
  Future<void> logout() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 500));

    // Remove dados armazenados
    await _secureStorage.delete(key: AppConstants.accessTokenKey);
    await _secureStorage.delete(key: AppConstants.refreshTokenKey);
    await _secureStorage.delete(key: AppConstants.userDataKey);
    await _secureStorage.delete(key: AppConstants.lastLoginKey);
  }

  /// Atualiza o token de autenticação
  Future<AuthToken> refreshToken() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 800));

    final refreshToken = await _secureStorage.read(
      key: AppConstants.refreshTokenKey,
    );

    if (refreshToken == null) {
      throw AuthException('Refresh token não encontrado');
    }

    // Gera novo token mock
    final newToken = _generateMockToken();

    // Atualiza storage
    await _secureStorage.write(
      key: AppConstants.accessTokenKey,
      value: newToken.accessToken,
    );
    await _secureStorage.write(
      key: AppConstants.refreshTokenKey,
      value: newToken.refreshToken,
    );

    return newToken;
  }

  /// Obtém usuário atual armazenado
  Future<UserModel?> getCurrentUser() async {
    final userDataString = await _secureStorage.read(
      key: AppConstants.userDataKey,
    );

    if (userDataString == null) {
      return null;
    }

    try {
      return UserModel.fromJsonString(userDataString);
    } catch (e) {
      return null;
    }
  }

  /// Verifica se usuário está autenticado
  Future<bool> isAuthenticated() async {
    final accessToken = await _secureStorage.read(
      key: AppConstants.accessTokenKey,
    );
    return accessToken != null;
  }

  /// Obtém access token atual
  Future<String?> getAccessToken() async {
    return _secureStorage.read(key: AppConstants.accessTokenKey);
  }

  /// Gera token mock
  AuthToken _generateMockToken() {
    final now = DateTime.now();
    final expiresAt = now.add(
      const Duration(minutes: AppConstants.tokenExpirationMinutes),
    );

    return AuthToken(
      accessToken: 'mock_access_${_generateRandomString(32)}',
      refreshToken: 'mock_refresh_${_generateRandomString(32)}',
      expiresAt: expiresAt,
      tokenType: 'Bearer',
    );
  }

  /// Gera string aleatória
  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  /// Gera ID único
  String _generateId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}_${_generateRandomString(8)}';
  }

  /// Extrai nome do email
  String _extractNameFromEmail(String email) {
    final username = email.split('@').first;
    final parts = username.split('.');
    return parts
        .map((part) =>
            part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join(' ');
  }
}
