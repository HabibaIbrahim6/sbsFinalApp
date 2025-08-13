import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class ApiService {
  final AuthService authService;

  ApiService(this.authService);

  static const String _baseUrl = 'https://your-api-domain.com/api';

  // جلب المنتجات
  Future<List<Map<String, dynamic>>> getProducts({
    String? location,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? availableOnly,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/products').replace(
        queryParameters: {
          if (location != null) 'location': location,
          if (category != null) 'category': category,
          if (minPrice != null) 'min_price': minPrice.toString(),
          if (maxPrice != null) 'max_price': maxPrice.toString(),
          if (availableOnly != null) 'available': availableOnly.toString(),
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (authService.token != null)
            'Authorization': 'Bearer ${authService.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['products']);
      }
      throw Exception('Failed to load products');
    } catch (e) {
      print('Get products error: $e');
      throw Exception('Failed to load products');
    }
  }

  // إضافة منتج جديد
  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authService.token}',
        },
        body: json.encode(productData),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      throw Exception('Failed to add product');
    } catch (e) {
      print('Add product error: $e');
      throw Exception('Failed to add product');
    }
  }

  // حجز منتج
  Future<bool> rentProduct(int productId, DateTime startDate, DateTime endDate) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/rentals'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authService.token}',
        },
        body: json.encode({
          'product_id': productId,
          'start_date': startDate.toIso8601String(),
          'end_date': endDate.toIso8601String(),
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Rent product error: $e');
      return false;
    }
  }
}