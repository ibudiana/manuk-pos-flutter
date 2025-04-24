class ApiConfig {
  static const String _baseDomain = 'http://10.0.2.2:8080';
  static const String _apiPath = '/api';

  static String get baseUrl => '$_baseDomain$_apiPath';

  // Endpoints
  static String roles() => '$baseUrl/roles';
}
