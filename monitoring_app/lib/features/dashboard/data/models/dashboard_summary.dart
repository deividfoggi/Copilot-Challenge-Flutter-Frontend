import 'package:contoso_tracking/features/dashboard/data/models/alert_model.dart';
import 'package:contoso_tracking/features/dashboard/data/models/unidade_regional_status.dart';

/// Resumo completo do dashboard
class DashboardSummary {
  const DashboardSummary({
    required this.alertas,
    required this.unidadesRegionais,
    required this.lastUpdate,
  });

  final List<AlertModel> alertas;
  final List<UnidadeRegionalStatus> unidadesRegionais;
  final DateTime lastUpdate;

  int get totalAlertas =>
      alertas.fold(0, (sum, alert) => sum + alert.count);

  int get unidadesComAlertas =>
      unidadesRegionais.where((u) => u.hasAlertas).length;

  int get totalUnidades => unidadesRegionais.length;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      alertas: (json['alertas'] as List<dynamic>)
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unidadesRegionais: (json['unidades_regionais'] as List<dynamic>)
          .map((e) => UnidadeRegionalStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdate: DateTime.parse(json['last_update'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alertas': alertas.map((e) => e.toJson()).toList(),
      'unidades_regionais': unidadesRegionais.map((e) => e.toJson()).toList(),
      'last_update': lastUpdate.toIso8601String(),
    };
  }

  DashboardSummary copyWith({
    List<AlertModel>? alertas,
    List<UnidadeRegionalStatus>? unidadesRegionais,
    DateTime? lastUpdate,
  }) {
    return DashboardSummary(
      alertas: alertas ?? this.alertas,
      unidadesRegionais: unidadesRegionais ?? this.unidadesRegionais,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
