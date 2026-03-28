import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Config/config.dart';
import '../models/health_response.dart';

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
}
