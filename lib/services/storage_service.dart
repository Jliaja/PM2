import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class StorageService {
  static const String _keyProducts = 'inventory_products';

  static final List<Product> _initialProducts = [
    Product(
      id: '1',
      name: 'Nike Air Max',
      price: 1200000,
      description:
          'Sepatu sneakers dengan desain modern dan nyaman digunakan untuk aktivitas sehari-hari.',
      category: 'Sepatu',
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    ),
    Product(
      id: '2',
      name: 'Adidas Superstar',
      price: 950000,
      description:
          'Sneakers klasik dengan desain simpel yang cocok digunakan untuk berbagai aktivitas.',
      category: 'Sepatu',
      image:
          'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=800',
    ),
    Product(
      id: '3',
      name: 'Hoodie Black',
      price: 350000,
      description:
          'Hoodie warna hitam dengan bahan nyaman dan cocok digunakan untuk kegiatan sehari-hari.',
      category: 'Pakaian',
      image:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=800',
    ),
    Product(
      id: '4',
      name: 'Casio Watch',
      price: 750000,
      description:
          'Jam tangan dengan desain klasik dan elegan untuk digunakan sehari-hari.',
      category: 'Aksesoris',
      image:
          'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800',
    ),
  ];

  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsJson = prefs.getString(_keyProducts);

    if (productsJson == null) {
      await saveProducts(_initialProducts);
      return _initialProducts;
    }

    final List<dynamic> decodedList = json.decode(productsJson);
    return decodedList.map((e) => Product.fromMap(e)).toList();
  }

  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString =
        json.encode(products.map((p) => p.toMap()).toList());
    await prefs.setString(_keyProducts, jsonString);
  }
}