import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:contoso_tracking/core/theme/app_theme.dart';
import 'package:contoso_tracking/features/auth/presentation/providers/auth_provider.dart';
import 'package:contoso_tracking/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:contoso_tracking/features/dashboard/presentation/widgets/unidades_regionais_table.dart';
import 'package:contoso_tracking/shared/widgets/alert_card.dart';
import 'package:contoso_tracking/shared/widgets/loading_and_error_widgets.dart'
    as widgets;

/// Tela principal do Dashboard
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Future<void> _handleRefresh() async {
    await ref.read(dashboardProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final dashboardAsync = ref.watch(dashboardProvider);
    final filteredUnidadesAsync = ref.watch(filteredUnidadesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard - Contoso'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar agora',
            onPressed: _handleRefresh,
          ),
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: dashboardAsync.when(
          data: (summary) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header com info do usuário
                if (user != null) ...[
                  _buildUserHeader(context, user),
                  const SizedBox(height: AppTheme.paddingLarge),
                ],

                // Última atualização
                _buildLastUpdateInfo(context, summary.lastUpdate),
                const SizedBox(height: AppTheme.paddingLarge),

                // Cards de alertas
                Text(
                  'Alertas Ativos',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppTheme.paddingMedium),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 1200
                        ? 4
                        : constraints.maxWidth > 800
                            ? 2
                            : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: AppTheme.paddingMedium,
                        mainAxisSpacing: AppTheme.paddingMedium,
                      ),
                      itemCount: summary.alertas.length,
                      itemBuilder: (context, index) {
                        final alert = summary.alertas[index];
                        return AlertCard(
                          alert: alert,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Visualizar detalhes',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: AppTheme.paddingXLarge),

                // Tabela de unidades regionais
                filteredUnidadesAsync.when(
                  data: (unidades) => UnidadesRegionaisTable(
                    unidades: unidades,
                  ),
                  loading: () => const widgets.LoadingOverlay(),
                  error: (error, _) => widgets.ErrorStateWidget(
                    message: error.toString(),
                    onRetry: _handleRefresh,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const widgets.LoadingOverlay(),
          error: (error, _) => widgets.ErrorStateWidget(
            message: error.toString(),
            onRetry: _handleRefresh,
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context, user) {
    return Card(
      elevation: AppTheme.elevationLow,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              child: Text(
                user.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    user.role,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastUpdateInfo(BuildContext context, DateTime lastUpdate) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.update,
            size: 16,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: AppTheme.paddingSmall),
          Text(
            'Última atualização: ${formatter.format(lastUpdate)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar saída'),
        content: const Text('Deseja realmente sair do sistema?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      await ref.read(authProvider.notifier).logout();
    }
  }
}
