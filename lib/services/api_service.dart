import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://pos.cicd.web.id',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // 1. GET ALL PRODUCTS
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/items/products');
      final List data = response.data['data'];
      return data.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 2. POST CREATE PRODUCT
  Future<Product> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        '/items/products',
        data: product.toJson(),
      );
      return Product.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 3. PATCH UPDATE PRODUCT
  Future<Product> updateProduct(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(
        '/items/products/$id',
        data: data,
      );
      return Product.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // 4. DELETE PRODUCT
  Future<void> deleteProduct(String id) async {
    try {
      await _dio.delete('/items/products/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Koneksi timeout, periksa internet kamu.';
    } else if (e.response != null) {
      final statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 400:
          return 'Bad Request (400): Format data salah.';
        case 401:
          return 'Unauthorized (401): Sesi telah berakhir.';
        case 403:
          return 'Forbidden (403): Akses ditolak.';
        case 404:
          return 'Not Found (404): Endpoint atau data tidak ditemukan.';
        case 500:
          return 'Server Error (500): Terjadi gangguan di server.';
        default:
          return 'Error HTTP ($statusCode): ${e.response?.statusMessage}';
      }
    }
    return 'Terjadi kesalahan jaringan: ${e.message}';
  }
}