/// Configuração de ambientes da aplicação
enum AppEnvironment {
  dev,
  prod,
}

/// Classe de configuração de ambiente
class Environment {
  Environment._();

  static AppEnvironment _environment = AppEnvironment.dev;

  /// Ambiente atual
  static AppEnvironment get environment => _environment;

  /// Define o ambiente
  static void setEnvironment(AppEnvironment env) {
    _environment = env;
  }

  /// Verifica se é ambiente de desenvolvimento
  static bool get isDev => _environment == AppEnvironment.dev;

  /// Verifica se é ambiente de produção
  static bool get isProd => _environment == AppEnvironment.prod;

  /// URL base da API
  static String get apiBaseUrl {
    switch (_environment) {
      case AppEnvironment.dev:
        return 'https://api-dev.contoso.domain';
      case AppEnvironment.prod:
        return 'https://api.contoso.domain';
    }
  }

  /// Timeout padrão para requisições (em segundos)
  static int get timeoutSeconds => 30;

  /// Intervalo de refresh do dashboard (em segundos)
  static int get dashboardRefreshInterval => 30;

  /// Habilitar logs
  static bool get enableLogs => isDev;

  /// Nome do ambiente
  static String get environmentName {
    switch (_environment) {
      case AppEnvironment.dev:
        return 'Desenvolvimento';
      case AppEnvironment.prod:
        return 'Produção';
    }
  }

  /// Versão da API
  static String get apiVersion => 'v1';

  /// OAuth2 Client ID (mock para MVP)
  static String get oauthClientId {
    switch (_environment) {
      case AppEnvironment.dev:
        return 'contoso-tracking-dev';
      case AppEnvironment.prod:
        return 'contoso-tracking-prod';
    }
  }

  /// OAuth2 Client Secret (mock para MVP)
  static String get oauthClientSecret {
    switch (_environment) {
      case AppEnvironment.dev:
        return 'dev-secret-12345';
      case AppEnvironment.prod:
        return 'prod-secret-67890';
    }
  }
}
