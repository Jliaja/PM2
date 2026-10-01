import 'dart:convert';

class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Umum',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }
}