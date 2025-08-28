import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laravel_api/models/product_model.dart';

class ProductService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/product';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<ProductModel> listProduct() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw Exception('Gagal memuat produk: ${response.body}');
    }
  }

  static Future<ProductModel> getProductDetail(int id) async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw Exception('Gagal memuat detail produk: ${response.body}');
    }
  }
}
