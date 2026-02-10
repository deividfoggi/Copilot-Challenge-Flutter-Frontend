import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:contoso_tracking/features/auth/presentation/providers/auth_provider.dart';

/// Guard de autenticação para GoRouter
class AuthGuard {
  const AuthGuard(this.ref);

  final Ref ref;

  /// Redireciona usuário não autenticado para login
  String? redirect(BuildContext context, GoRouterState state) {
    final authState = ref.read(authProvider);
    final isLoginRoute = state.matchedLocation == '/login';

    if (!authState.isAuthenticated && !isLoginRoute) {
      return '/login';
    }

    if (authState.isAuthenticated && isLoginRoute) {
      return '/';
    }

    return null;
  }
}
