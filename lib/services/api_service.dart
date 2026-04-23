import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api-colombia.com/api/v1";

  Future<List<dynamic>> getData(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");

    try {
      final response = await http.get(url);

      // 🧠 DEBUG SEGURO (mejor que print)
      log("URL: $url");
      log("STATUS: ${response.statusCode}");
      log("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "Error ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      // 🔥 ERROR REAL DE CONEXIÓN
      throw Exception("Error de conexión: $e");
    }
  }
}