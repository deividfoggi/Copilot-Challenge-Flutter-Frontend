import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:contoso_tracking/features/auth/data/models/user_model.dart';
import 'package:contoso_tracking/features/auth/data/services/auth_service.dart';

/// Provider para FlutterSecureStorage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
});

/// Provider para AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthService(secureStorage);
});

/// Estado de autenticação
class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  final UserModel? user;
  final bool isLoading;
  final String? error;

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  AuthState clearError() {
    return AuthState(
      user: user,
      isLoading: isLoading,
      error: null,
    );
  }

  AuthState clearUser() {
    return const AuthState(
      user: null,
      isLoading: false,
      error: null,
    );
  }
}

/// Notifier para gerenciar estado de autenticação
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._authService) : super(const AuthState()) {
    _checkAuthStatus();
  }

  final AuthService _authService;

  /// Verifica status de autenticação ao inicializar
  Future<void> _checkAuthStatus() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        state = AuthState(user: user);
      }
    } catch (e) {
      // Ignora erros na verificação inicial
    }
  }

  /// Realiza login
  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authService.login(
        username: username,
        password: password,
      );
      state = AuthState(user: user);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  /// Realiza logout
  Future<void> logout() async {
    try {
      await _authService.logout();
      state = state.clearUser();
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  /// Limpa erro
  void clearError() {
    state = state.clearError();
  }
}

/// Provider para estado de autenticação
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
