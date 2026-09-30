import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_config.dart';
import '../models/governate_model.dart';
import '../models/specialization_model.dart';

abstract class SharedRemoteDataSource {
  Future<List<GovernateModel>> getGovernates();
  Future<List<SpecializationModel>> getSpecializations();
}

class SharedRemoteDataSourceImpl implements SharedRemoteDataSource {
  final http.Client client;
  final SharedPreferences prefs;

  SharedRemoteDataSourceImpl({required this.client, required this.prefs});

  Future<String> _getToken() async {
    final rawSession = prefs.getString('auth_session');
    if (rawSession == null || rawSession.isEmpty) {
      throw UnauthorizedException(); // No token means instantly unauthorized
    }
    final jsonMap = json.decode(rawSession) as Map<String, dynamic>;
    return jsonMap['token'] ?? '';
  }

  @override
  Future<List<GovernateModel>> getGovernates() async {
    final token = await _getToken();
    final uri = Uri.parse('${ApiConfig.baseUrl}/governates');
    
    final response = await client.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // --- STATUS CODE PROCESSING STAYS HERE ---
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List data = jsonResponse['data'] ?? jsonResponse; 
      return data.map((e) => GovernateModel.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(); // Translate 401 into a domain exception
    } else {
      throw ServerException(); // Translate all other errors
    }
  }

  @override
  Future<List<SpecializationModel>> getSpecializations() async {
    final token = await _getToken();
    final uri = Uri.parse('${ApiConfig.baseUrl}/specializations');
    
    final response = await client.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // --- STATUS CODE PROCESSING STAYS HERE ---
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List data = jsonResponse['data'] ?? jsonResponse;
      return data.map((e) => SpecializationModel.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }
}