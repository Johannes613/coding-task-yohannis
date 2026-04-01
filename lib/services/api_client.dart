import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String _baseUrl = 'https://dummyjson.com';

  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String path,
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('$_baseUrl$path').replace(
      queryParameters: queryParams,
    );
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('HTTP ${response.statusCode} — $path');
  }
}
