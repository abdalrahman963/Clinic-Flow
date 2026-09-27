class ApiConfig {
  // Keep it configurable without touching code.
  // Example: flutter run --dart-define=API_BASE_URL=https://your-domain.com/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.1.142:8000/api',
  );
}

