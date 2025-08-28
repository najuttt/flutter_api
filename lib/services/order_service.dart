import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laravel_api/models/order_model.dart';

class OrderService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/order';
  static const String productUrl = 'http://127.0.0.1:8000/api/product';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<double?> getProductPrice(int productId) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.get(
      Uri.parse('$productUrl/$productId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData['data']['harga'] as num).toDouble();
    } else {
      throw Exception('Gagal memuat harga produk: ${response.body}');
    }
  }

  static Future<List<DataOrder>> listOrder() async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<DataOrder> orders = [];
      for (var item in jsonData['data'] as List) {
        final order = DataOrder.fromJson(item);
        final harga = await getProductPrice(order.productId);
        orders.add(DataOrder(
          id: order.id,
          userId: order.userId,
          productId: order.productId,
          jumlah: order.jumlah,
          productName: order.productName,
          harga: harga,
        ));
      }
      return orders;
    } else {
      throw Exception('Gagal memuat pesanan: ${response.body}');
    }
  }

  static Future<bool> createOrder({
    required int productId,
    required int jumlah,
  }) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({'product_id': productId, 'jumlah': jumlah}),
    );

    return response.statusCode == 201;
  }

  static Future<DataOrder> getOrderDetail(int orderId) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.get(
      Uri.parse('$baseUrl/$orderId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final order = DataOrder.fromJson(jsonData['data']);
      final harga = await getProductPrice(order.productId);
      return DataOrder(
        id: order.id,
        userId: order.userId,
        productId: order.productId,
        jumlah: order.jumlah,
        productName: order.productName,
        harga: harga,
      );
    } else {
      throw Exception('Gagal memuat detail pesanan: ${response.body}');
    }
  }

  static Future<bool> updateOrder({
    required int orderId,
    required int productId,
    required int jumlah,
  }) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.put(
      Uri.parse('$baseUrl/$orderId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({'product_id': productId, 'jumlah': jumlah}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Update order failed: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal memperbarui pesanan: ${response.body}');
    }
  }

  static Future<bool> deleteOrder(int orderId) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.delete(
      Uri.parse('$baseUrl/$orderId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response.statusCode == 204 || response.statusCode == 200; // Tambahkan 200 jika backend mengembalikan 200
  }

  static Future<bool> payOrder(int orderId) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan, silakan login ulang.');

    final response = await http.post(
      Uri.parse('$baseUrl/$orderId/pay'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response.statusCode == 200;
  }
}
