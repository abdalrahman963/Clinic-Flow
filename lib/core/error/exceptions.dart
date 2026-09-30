class ServerException implements Exception {}

// --- NEW EXCEPTIONS ---
class CacheException implements Exception {}

class UnauthorizedException implements Exception {}

// --- EXISTING EXCEPTIONS ---
class LocationPermissionException implements Exception {}

class LocationDisabledException implements Exception {}

class ApiException implements Exception {
  ApiException({required this.message, this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}