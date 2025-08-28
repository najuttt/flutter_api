import 'package:equatable/equatable.dart';

class DataOrder extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final int jumlah;
  final String productName;
  final double? harga; 

  const DataOrder({
    required this.id,
    required this.userId,
    required this.productId,
    required this.jumlah,
    required this.productName,
    this.harga,
  });

  factory DataOrder.fromJson(Map<String, dynamic> json) {
    return DataOrder(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      jumlah: json['jumlah'] as int,
      productName: json['product']['nama'] as String,
      harga: json['harga'] != null ? (json['harga'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'jumlah': jumlah,
      'product': {'nama': productName},
      if (harga != null) 'harga': harga,
    };
  }

  @override
  List<Object?> get props => [id, userId, productId, jumlah, productName, harga];
}