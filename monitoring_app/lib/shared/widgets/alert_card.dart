import 'package:flutter/material.dart';
import 'package:contoso_tracking/core/theme/app_theme.dart';
import 'package:contoso_tracking/features/dashboard/data/models/alert_model.dart';

/// Card de alerta do dashboard
class AlertCard extends StatelessWidget {
  const AlertCard({
    required this.alert,
    required this.onTap,
    super.key,
  });

  final AlertModel alert;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _getColorBySeverity(alert.severity);

    return Card(
      elevation: AppTheme.elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        side: BorderSide(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.paddingSmall),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusSmall,
                      ),
                    ),
                    child: Text(
                      alert.type.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.paddingSmall,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusSmall,
                      ),
                    ),
                    child: Text(
                      _getSeverityLabel(alert.severity),
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.paddingMedium),
              Text(
                alert.type.displayName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppTheme.paddingSmall),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${alert.count}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: AppTheme.paddingSmall),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'ocorrências',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorBySeverity(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return AppTheme.alertCritical;
      case AlertSeverity.high:
        return AppTheme.alertHigh;
      case AlertSeverity.medium:
        return AppTheme.alertMedium;
      case AlertSeverity.low:
        return AppTheme.alertLow;
    }
  }

  String _getSeverityLabel(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return 'CRÍTICO';
      case AlertSeverity.high:
        return 'ALTO';
      case AlertSeverity.medium:
        return 'MÉDIO';
      case AlertSeverity.low:
        return 'BAIXO';
    }
  }
}
