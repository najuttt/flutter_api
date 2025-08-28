import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    List<DataKategori>? data;
    String? message;
    bool? success;

    PostModel({
        this.data,
        this.message,
        this.success,
    });

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        data: json["data"] == null ? [] : List<DataKategori>.from(json["data"]!.map((x) => DataKategori.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class DataKategori {
    int? id;
    String? nama;
    String? slug;
    DateTime? createdAt;
    DateTime? updatedAt;

    DataKategori({
        this.id,
        this.nama,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    factory DataKategori.fromJson(Map<String, dynamic> json) => DataKategori(
        id: json["id"],
        nama: json["nama"],
        slug: json["slug"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
