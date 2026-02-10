/// Constantes da aplicação
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Contoso Tracking';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String lastLoginKey = 'last_login';

  // API Endpoints
  static const String authEndpoint = '/auth/login';
  static const String refreshEndpoint = '/auth/refresh';
  static const String logoutEndpoint = '/auth/logout';
  static const String dashboardEndpoint = '/dashboard/summary';
  static const String alertsEndpoint = '/alerts';
  static const String unitsEndpoint = '/units';

  // Timeout values (milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Token expiration (mock - 1 hour)
  static const int tokenExpirationMinutes = 60;

  // Refresh intervals
  static const int dashboardRefreshSeconds = 30;
  static const int alertsRefreshSeconds = 15;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Alert Types
  static const String alertRoteador = 'ROTEADOR';
  static const String alertFirewall = 'FIREWALL';
  static const String alertSdwan = 'SDWAN';
  static const String alertStarlink = 'STARLINK';

  // Regional Units
  static const List<String> regionalUnits = [
    'ADAMANTINA',
    'AMERICANA',
    'ANDRADINA',
    'APIAI',
    'ARAÇATUBA',
    'ARARAQUARA',
    'ASSIS',
    'AVARÉ',
    'BARRETOS',
    'BAURU',
    'BIRIGUI',
    'BOTUCATU',
    'BRAGANÇA PAULISTA',
    'CAMPINAS LESTE',
    'CAMPINAS OESTE',
    'CAPIVARI',
    'CARAPICUÍBA',
    'CARAGUATATUBA',
    'CATANDUVA',
    'CAIEIRAS',
  ];

  // Mock Credentials (for MVP only)
  static const String mockUsername = 'admin@contoso.domain';
  static const String mockPassword = 'Admin@123';
}
