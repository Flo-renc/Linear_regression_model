import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://aiwhisper-2qgt.onrender.com";

  static Future<double> predict(Map<String, dynamic> input) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(input),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print("Response body: ${response.body}");
      }
      if (data.containsKey("prediction")) {
        return data["prediction"] is int
            ? (data["prediction"] as int).toDouble()
            : data["prediction"];
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      final err = jsonDecode(response.body);
      throw Exception(err['detail'] ?? 'Prediction failed');
    }
  }
}
