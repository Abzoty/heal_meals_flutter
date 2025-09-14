import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/shared_pref.dart';

class ApiClient {
  final http.Client _client = http.Client();

  /// Builds headers with optional authorization token
  Future<Map<String, String>> _buildHeaders() async {
    final token = await SharedPrefHelper.getSecuredString("token");

    final headers = {"Content-Type": "application/json"};

    if (token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final headers = await _buildHeaders();

    final response = await _client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    return _processResponse(response); // 👈 now dynamic
  }

  Future<dynamic> get(String url) async {
    final headers = await _buildHeaders();

    final response = await _client.get(Uri.parse(url), headers: headers);

    return _processResponse(response); // 👈 now dynamic
  }

  /// Centralized response handling
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body); // 👈 can be Map OR List
    } else {
      throw Exception(
        "Failed request: ${response.statusCode} - ${response.body}",
      );
    }
  }
}
