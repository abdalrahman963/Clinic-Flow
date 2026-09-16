import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_config.dart';
import '../models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<void> logout({required String token});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/login');
    http.Response res;
    try {
      res = await client.post(
        uri,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
    } catch (e) {
      throw ApiException(message: 'Network error. Check base URL and connection.');
    }

    Map<String, dynamic>? jsonMap;
    try {
      jsonMap = json.decode(res.body) as Map<String, dynamic>;
    } catch (_) {
      jsonMap = null;
    }

    if (res.statusCode != 200) {
      final msg = (jsonMap?['message'] ?? 'Login failed.').toString();
      throw ApiException(message: msg, statusCode: res.statusCode);
    }

    if (jsonMap == null) {
      throw ApiException(message: 'Invalid server response.', statusCode: res.statusCode);
    }

    return AuthSessionModel.fromJson(jsonMap);
  }

  @override
  Future<void> logout({required String token}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/logout');
    http.Response res;
    try {
      res = await client.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (_) {
      throw ApiException(message: 'Network error while logging out.');
    }

    if (res.statusCode != 200) {
      Map<String, dynamic>? jsonMap;
      try {
        jsonMap = json.decode(res.body) as Map<String, dynamic>;
      } catch (_) {
        jsonMap = null;
      }
      final msg = (jsonMap?['message'] ?? 'Logout failed.').toString();
      throw ApiException(message: msg, statusCode: res.statusCode);
    }
  }
}

