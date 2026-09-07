// To parse this JSON data, do
//
//     final platziProduct = platziProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PlatziProduct> platziProductFromJson(String str) => List<PlatziProduct>.from(json.decode(str).map((x) => PlatziProduct.fromJson(x)));

String platziProductToJson(List<PlatziProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlatziProduct {
    int id;
    String title;
    String slug;
    int price;
    String description;
    Category category;
    List<String> images;
    String creationAt;
    String updatedAt;

    PlatziProduct({
        required this.id,
        required this.title,
        required this.slug,
        required this.price,
        required this.description,
        required this.category,
        required this.images,
        required this.creationAt,
        required this.updatedAt,
    });

    factory PlatziProduct.fromJson(Map<String, dynamic> json) => PlatziProduct(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        price: json["price"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        images: List<String>.from(json["images"].map((x) => x)),
        creationAt: json["creationAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "price": price,
        "description": description,
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "creationAt": creationAt,
        "updatedAt": updatedAt,
    };
}

class Category {
    int id;
    String name;
    String slug;
    String image;
    String creationAt;
    String updatedAt;

    Category({
        required this.id,
        required this.name,
        required this.slug,
        required this.image,
        required this.creationAt,
        required this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: json["creationAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "creationAt": creationAt,
        "updatedAt": updatedAt,
    };
}
