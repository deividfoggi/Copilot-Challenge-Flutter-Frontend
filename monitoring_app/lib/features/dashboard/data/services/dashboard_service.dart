import 'package:contoso_tracking/core/constants/app_constants.dart';
import 'package:contoso_tracking/features/dashboard/data/models/alert_model.dart';
import 'package:contoso_tracking/features/dashboard/data/models/dashboard_summary.dart';
import 'package:contoso_tracking/features/dashboard/data/models/unidade_regional_status.dart';

/// Serviço mock para dados do dashboard
class DashboardService {
  DashboardService();

  /// Busca resumo do dashboard (mock com dados aleatórios)
  Future<DashboardSummary> getDashboardSummary() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 800));

    final alertas = _generateMockAlertas();
    final unidades = _generateMockUnidades();

    return DashboardSummary(
      alertas: alertas,
      unidadesRegionais: unidades,
      lastUpdate: DateTime.now(),
    );
  }

  /// Gera alertas mock
  List<AlertModel> _generateMockAlertas() {
    return [
      AlertModel(
        id: 'alert-roteador',
        type: AlertType.roteador,
        count: 42,
        severity: AlertSeverity.high,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      AlertModel(
        id: 'alert-firewall',
        type: AlertType.firewall,
        count: 18,
        severity: AlertSeverity.medium,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      AlertModel(
        id: 'alert-sdwan',
        type: AlertType.sdwan,
        count: 7,
        severity: AlertSeverity.critical,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      AlertModel(
        id: 'alert-starlink',
        type: AlertType.starlink,
        count: 3,
        severity: AlertSeverity.low,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ];
  }

  /// Gera dados mock de unidades regionais
  List<UnidadeRegionalStatus> _generateMockUnidades() {
    // Fixed mock data for consistent demo across platforms
    final mockData = {
      'CAPITAL': {'roteador': 5, 'firewall': 2, 'sdwan': 1, 'starlink': 0},
      'CAMPINAS OESTE': {'roteador': 3, 'firewall': 1, 'sdwan': 0, 'starlink': 1},
      'CAMPINAS LESTE': {'roteador': 2, 'firewall': 1, 'sdwan': 1, 'starlink': 0},
      'SOROCABA': {'roteador': 4, 'firewall': 2, 'sdwan': 0, 'starlink': 0},
      'VALE DO PARAÍBA': {'roteador': 2, 'firewall': 0, 'sdwan': 1, 'starlink': 1},
      'RIBEIRÃO PRETO': {'roteador': 3, 'firewall': 1, 'sdwan': 1, 'starlink': 0},
      'BAURU': {'roteador': 1, 'firewall': 1, 'sdwan': 0, 'starlink': 0},
      'SÃO JOSÉ DO RIO PRETO': {'roteador': 2, 'firewall': 0, 'sdwan': 1, 'starlink': 0},
      'ARAÇATUBA': {'roteador': 1, 'firewall': 1, 'sdwan': 0, 'starlink': 1},
      'PRESIDENTE PRUDENTE': {'roteador': 2, 'firewall': 1, 'sdwan': 1, 'starlink': 0},
      'MARÍLIA': {'roteador': 1, 'firewall': 0, 'sdwan': 0, 'starlink': 0},
      'ASSIS': {'roteador': 1, 'firewall': 1, 'sdwan': 0, 'starlink': 0},
      'ARARAQUARA': {'roteador': 2, 'firewall': 1, 'sdwan': 1, 'starlink': 0},
      'SÃO JOÃO DA BOA VISTA': {'roteador': 1, 'firewall': 0, 'sdwan': 0, 'starlink': 1},
      'AMERICANA': {'roteador': 3, 'firewall': 1, 'sdwan': 0, 'starlink': 0},
      'PIRACICABA': {'roteador': 2, 'firewall': 1, 'sdwan': 1, 'starlink': 0},
      'LIMEIRA': {'roteador': 2, 'firewall': 1, 'sdwan': 0, 'starlink': 0},
      'ITAPETININGA': {'roteador': 1, 'firewall': 0, 'sdwan': 1, 'starlink': 0},
      'REGISTRO': {'roteador': 1, 'firewall': 1, 'sdwan': 0, 'starlink': 0},
      'SANTOS': {'roteador': 3, 'firewall': 2, 'sdwan': 1, 'starlink': 0},
    };

    return AppConstants.regionalUnits.map((nome) {
      final data = mockData[nome] ?? {'roteador': 0, 'firewall': 0, 'sdwan': 0, 'starlink': 0};
      return UnidadeRegionalStatus(
        nome: nome,
        roteador: data['roteador']!,
        firewall: data['firewall']!,
        sdwan: data['sdwan']!,
        starlink: data['starlink']!,
      );
    }).toList();
  }

  /// Busca unidades regionais filtradas
  Future<List<UnidadeRegionalStatus>> getUnidadesRegionais({
    String? filtroNome,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var unidades = _generateMockUnidades();

    if (filtroNome != null && filtroNome.isNotEmpty) {
      unidades = unidades
          .where((u) => u.nome.toLowerCase().contains(filtroNome.toLowerCase()))
          .toList();
    }

    return unidades;
  }
}
