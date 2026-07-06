class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://129.121.119.137/api/v1',
    //defaultValue: 'http://localhost:5000/api/v1',
  );
}