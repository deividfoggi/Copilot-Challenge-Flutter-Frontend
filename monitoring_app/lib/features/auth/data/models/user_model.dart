import 'dart:convert';

/// Modelo de usuário autenticado
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.regionalUnit,
  });

  final String id;
  final String name;
  final String email;
  final String role;
  final String? regionalUnit;

  /// Cria um UserModel a partir de JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      regionalUnit: json['regional_unit'] as String?,
    );
  }

  /// Converte UserModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'regional_unit': regionalUnit,
    };
  }

  /// Converte UserModel para String JSON
  String toJsonString() => json.encode(toJson());

  /// Cria um UserModel a partir de String JSON
  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);
  }

  /// Cria cópia com modificações
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? regionalUnit,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      regionalUnit: regionalUnit ?? this.regionalUnit,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role, regionalUnit: $regionalUnit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        other.regionalUnit == regionalUnit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        regionalUnit.hashCode;
  }
}
