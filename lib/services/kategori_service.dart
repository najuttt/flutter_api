import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laravel_api/models/kategori_model.dart';

class KategoriService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/kategori';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<PostModel> listKategori() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return PostModel.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat kategori');
    }
  }
}
