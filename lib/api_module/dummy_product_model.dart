// To parse this JSON data, do
//
//     final products = dummyProductFromJson(jsonString);
//
// https://dummyjson.com/products returns an envelope:
//     { "products": [ ... ], "total": 194, "skip": 0, "limit": 30 }
// so the list parser digs into "products"; a single product
// (https://dummyjson.com/products/1) is a bare object.

import 'dart:convert';

List<DummyProduct> dummyProductFromJson(String str) => List<DummyProduct>.from(
  (json.decode(str)["products"] as List).map((x) => DummyProduct.fromJson(x)),
);

String dummyProductToJson(List<DummyProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DummyProduct {
    final int id;
    final String title;
    final String description;
    final String category;
    final double price;
    final double discountPercentage;
    final double rating;
    final int stock;
    final List<String> tags;
    final String? brand;
    final String sku;
    final int weight;
    final Dimensions dimensions;
    final String warrantyInformation;
    final String shippingInformation;
    final String availabilityStatus;
    final List<Review> reviews;
    final String returnPolicy;
    final int minimumOrderQuantity;
    final Meta meta;
    final List<String> images;
    final String thumbnail;

    DummyProduct({
        required this.id,
        required this.title,
        required this.description,
        required this.category,
        required this.price,
        required this.discountPercentage,
        required this.rating,
        required this.stock,
        required this.tags,
        this.brand,
        required this.sku,
        required this.weight,
        required this.dimensions,
        required this.warrantyInformation,
        required this.shippingInformation,
        required this.availabilityStatus,
        required this.reviews,
        required this.returnPolicy,
        required this.minimumOrderQuantity,
        required this.meta,
        required this.images,
        required this.thumbnail,
    });

    factory DummyProduct.fromJson(Map<String, dynamic> json) => DummyProduct(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        price: json["price"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        brand: json["brand"],
        sku: json["sku"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        warrantyInformation: json["warrantyInformation"],
        shippingInformation: json["shippingInformation"],
        availabilityStatus: json["availabilityStatus"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        returnPolicy: json["returnPolicy"],
        minimumOrderQuantity: json["minimumOrderQuantity"],
        meta: Meta.fromJson(json["meta"]),
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "brand": brand,
        "sku": sku,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "warrantyInformation": warrantyInformation,
        "shippingInformation": shippingInformation,
        "availabilityStatus": availabilityStatus,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "returnPolicy": returnPolicy,
        "minimumOrderQuantity": minimumOrderQuantity,
        "meta": meta.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
    };
}

class Dimensions {
    final double width;
    final double height;
    final double depth;

    Dimensions({
        required this.width,
        required this.height,
        required this.depth,
    });

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
    };
}

class Meta {
    final String createdAt;
    final String updatedAt;
    final String barcode;
    final String qrCode;

    Meta({
        required this.createdAt,
        required this.updatedAt,
        required this.barcode,
        required this.qrCode,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        barcode: json["barcode"],
        qrCode: json["qrCode"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "barcode": barcode,
        "qrCode": qrCode,
    };
}

class Review {
    final int rating;
    final String comment;
    final String date;
    final String reviewerName;
    final String reviewerEmail;

    Review({
        required this.rating,
        required this.comment,
        required this.date,
        required this.reviewerName,
        required this.reviewerEmail,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        comment: json["comment"],
        date: json["date"],
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date,
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
    };
}
