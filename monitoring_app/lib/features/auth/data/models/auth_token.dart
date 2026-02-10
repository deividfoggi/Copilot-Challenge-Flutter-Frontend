import 'dart:convert';

/// Modelo de token de autenticação
class AuthToken {
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.tokenType,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String tokenType;

  /// Verifica se o token expirou
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Tempo restante até expiração em minutos
  int get minutesUntilExpiration {
    final diff = expiresAt.difference(DateTime.now());
    return diff.inMinutes;
  }

  /// Cria um AuthToken a partir de JSON
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      tokenType: json['token_type'] as String? ?? 'Bearer',
    );
  }

  /// Converte AuthToken para JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.toIso8601String(),
      'token_type': tokenType,
    };
  }

  /// Converte AuthToken para String JSON
  String toJsonString() => json.encode(toJson());

  /// Cria um AuthToken a partir de String JSON
  factory AuthToken.fromJsonString(String jsonString) {
    return AuthToken.fromJson(json.decode(jsonString) as Map<String, dynamic>);
  }

  /// Cria cópia com modificações
  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    String? tokenType,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  String toString() {
    return 'AuthToken(tokenType: $tokenType, expiresAt: $expiresAt, isExpired: $isExpired)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthToken &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresAt == expiresAt &&
        other.tokenType == tokenType;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        refreshToken.hashCode ^
        expiresAt.hashCode ^
        tokenType.hashCode;
  }
}
