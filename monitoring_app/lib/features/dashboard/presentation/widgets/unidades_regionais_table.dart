import 'package:flutter/material.dart';
import 'package:contoso_tracking/core/theme/app_theme.dart';
import 'package:contoso_tracking/features/dashboard/data/models/unidade_regional_status.dart';

/// Tabela de alertas por unidade regional
class UnidadesRegionaisTable extends StatelessWidget {
  const UnidadesRegionaisTable({
    required this.unidades,
    super.key,
  });

  final List<UnidadeRegionalStatus> unidades;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppTheme.elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            child: Row(
              children: [
                const Icon(
                  Icons.table_chart,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: AppTheme.paddingSmall),
                Text(
                  'Alertas por Unidade Regional',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                AppTheme.primaryColor.withValues(alpha: 0.1),
              ),
              columns: const [
                DataColumn(
                  label: Text(
                    'UNIDADE REGIONAL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ROTEADOR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'FIREWALL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'SDWAN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'STARLINK',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(
                    'TOTAL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  numeric: true,
                ),
              ],
              rows: unidades.map((unidade) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        unidade.nome,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    DataCell(_buildCountCell(unidade.roteador, context)),
                    DataCell(_buildCountCell(unidade.firewall, context)),
                    DataCell(_buildCountCell(unidade.sdwan, context)),
                    DataCell(_buildCountCell(unidade.starlink, context)),
                    DataCell(
                      _buildTotalCell(unidade.totalAlertas, context),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountCell(int count, BuildContext context) {
    if (count == 0) {
      return Text(
        '0',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
      );
    }

    final color = count > 5
        ? AppTheme.alertHigh
        : count > 2
            ? AppTheme.alertMedium
            : AppTheme.alertLow;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.paddingSmall,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      ),
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildTotalCell(int total, BuildContext context) {
    if (total == 0) {
      return Text(
        '0',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.bold,
            ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.paddingMedium,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      ),
      child: Text(
        total.toString(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
