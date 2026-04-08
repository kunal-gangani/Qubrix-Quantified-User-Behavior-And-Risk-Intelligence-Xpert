import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Config/config.dart';
import '../Models/analyze_request.dart';
import '../Models/analyze_response.dart';
import '../Models/health_response.dart';
import '../Models/save_request.dart';
import '../Models/save_response.dart';

class ApiService {
  Future<HealthResponse> healthCheck() async {
    final uri = Uri.parse("${AppConfig.baseUrl}/health");
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Health check failed: ${res.statusCode} ${res.body}");
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return HealthResponse.fromJson(json);
  }

  Future<AnalyzeResponse> analyzeRisk(AnalyzeRequest request) async {
    final uri = Uri.parse("${AppConfig.baseUrl}/analyze");

    final res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception("Analyze failed: ${res.statusCode} ${res.body}");
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return AnalyzeResponse.fromJson(json);
  }

  Future<SaveResponse> saveToNotion(SaveRequest request) async {
    final uri = Uri.parse("${AppConfig.baseUrl}/save");

    final res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception("Save failed: ${res.statusCode} ${res.body}");
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return SaveResponse.fromJson(json);
  }
}
