import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contoso_tracking/features/dashboard/data/models/dashboard_summary.dart';
import 'package:contoso_tracking/features/dashboard/data/services/dashboard_service.dart';

/// Provider para DashboardService
final dashboardServiceProvider = Provider<DashboardService>((ref) {
  return DashboardService();
});

/// State notifier para gerenciar o dashboard
class DashboardNotifier extends StateNotifier<AsyncValue<DashboardSummary>> {
  DashboardNotifier(this._service) : super(const AsyncValue.loading()) {
    loadDashboard();
  }

  final DashboardService _service;
  Timer? _autoRefreshTimer;

  /// Carrega dados do dashboard
  Future<void> loadDashboard() async {
    state = const AsyncValue.loading();
    try {
      final summary = await _service.getDashboardSummary();
      state = AsyncValue.data(summary);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Força atualização manual
  Future<void> refresh() async {
    await loadDashboard();
  }

  /// Inicia auto-refresh
  void startAutoRefresh({Duration interval = const Duration(seconds: 30)}) {
    stopAutoRefresh();
    _autoRefreshTimer = Timer.periodic(interval, (_) {
      loadDashboard();
    });
  }

  /// Para auto-refresh
  void stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = null;
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
}

/// Provider para o estado do dashboard
final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, AsyncValue<DashboardSummary>>(
  (ref) {
    final service = ref.watch(dashboardServiceProvider);
    return DashboardNotifier(service);
  },
);

/// Provider para filtro de região
final regionalFilterProvider = StateProvider<String?>((ref) => null);

/// Provider para unidades filtradas
final filteredUnidadesProvider = Provider((ref) {
  final dashboardAsync = ref.watch(dashboardProvider);
  final filtro = ref.watch(regionalFilterProvider);

  return dashboardAsync.whenData((summary) {
    if (filtro == null || filtro.isEmpty) {
      return summary.unidadesRegionais;
    }

    return summary.unidadesRegionais
        .where((u) => u.nome.toLowerCase().contains(filtro.toLowerCase()))
        .toList();
  });
});

/// Provider para auto-refresh enabled
final autoRefreshEnabledProvider = StateProvider<bool>((ref) => true);
