import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  String? sId;
  String? name;
  String? description;
  String? datePosted;
  List<dynamic>? productImages;
  Product({this.sId, this.name, this.description, this.datePosted, this.productImages});

  Product copyWith({String? sId, String? name, String? description, String? datePosted, List<dynamic>? productImages}) {
    return Product(
      sId: sId ?? this.sId,
      name: name ?? this.name,
      description: description ?? this.description,
      datePosted: datePosted ?? this.datePosted,
      productImages: productImages ?? this.productImages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': sId,
      'name': name,
      'description': description,
      'datePosted': datePosted,
      'productImages': productImages,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      sId: map['_id'],
      name: map['name'],
      description: map['description'],
      datePosted: map['datePosted'],
      productImages: List<dynamic>.from(map['productImages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(_id: $sId, name: $name, description: $description, datePosted: $datePosted, productImages: $productImages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.sId == sId &&
        other.name == name &&
        other.description == description &&
        other.datePosted == datePosted &&
        listEquals(other.productImages, productImages);
  }

  @override
  int get hashCode {
    return sId.hashCode ^ name.hashCode ^ description.hashCode ^ datePosted.hashCode ^ productImages.hashCode;
  }
}
