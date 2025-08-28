import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) =>
    json.encode(data.toJson());

class ProductModel {
  List<Product>? data;
  String? message;
  bool? success;

  ProductModel({
    this.data,
    this.message,
    this.success,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class Product {
  int? id;
  String? nama;
  int? harga;
  String? deskripsi;
  String? foto;
  int? stok;
  int? kategoriId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Kategori? kategori;

  Product({
    this.id,
    this.nama,
    this.harga,
    this.deskripsi,
    this.foto,
    this.stok,
    this.kategoriId,
    this.createdAt,
    this.updatedAt,
    this.kategori,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        foto: json["foto"],
        stok: json["stok"],
        kategoriId: json["kategori_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        kategori: json["kategori"] == null
            ? null
            : Kategori.fromJson(json["kategori"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "deskripsi": deskripsi,
        "foto": foto,
        "stok": stok,
        "kategori_id": kategoriId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "kategori": kategori?.toJson(),
      };
}

class Kategori {
  int? id;
  String? nama;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kategori({
    this.id,
    this.nama,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        nama: json["nama"],
        slug: json["slug"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
