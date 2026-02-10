/// Modelo de alerta do sistema
class AlertModel {
  const AlertModel({
    required this.id,
    required this.type,
    required this.count,
    required this.severity,
    required this.lastUpdate,
  });

  final String id;
  final AlertType type;
  final int count;
  final AlertSeverity severity;
  final DateTime lastUpdate;

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] as String,
      type: AlertType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AlertType.roteador,
      ),
      count: json['count'] as int,
      severity: AlertSeverity.values.firstWhere(
        (e) => e.name == json['severity'],
        orElse: () => AlertSeverity.medium,
      ),
      lastUpdate: DateTime.parse(json['last_update'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'count': count,
      'severity': severity.name,
      'last_update': lastUpdate.toIso8601String(),
    };
  }
}

/// Tipos de alertas
enum AlertType {
  roteador,
  firewall,
  sdwan,
  starlink,
}

/// Severidade do alerta
enum AlertSeverity {
  critical,
  high,
  medium,
  low,
}

/// Extensão para AlertType com informações de UI
extension AlertTypeExtension on AlertType {
  String get displayName {
    switch (this) {
      case AlertType.roteador:
        return 'ROTEADOR';
      case AlertType.firewall:
        return 'FIREWALL';
      case AlertType.sdwan:
        return 'SDWAN';
      case AlertType.starlink:
        return 'STARLINK';
    }
  }

  String get icon {
    switch (this) {
      case AlertType.roteador:
        return '🔄';
      case AlertType.firewall:
        return '🛡️';
      case AlertType.sdwan:
        return '🌐';
      case AlertType.starlink:
        return '📡';
    }
  }
}
