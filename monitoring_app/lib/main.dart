import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contoso_tracking/core/config/environment.dart';
import 'package:contoso_tracking/core/routes/app_router.dart';
import 'package:contoso_tracking/core/theme/app_theme.dart';

void main() {
  // Define o ambiente (pode ser alterado com flavor)
  Environment.setEnvironment(AppEnvironment.dev);

  runApp(
    const ProviderScope(
      child: ContosoTrackingApp(),
    ),
  );
}

/// Aplicação principal
class ContosoTrackingApp extends ConsumerWidget {
  const ContosoTrackingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Contoso Tracking',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
