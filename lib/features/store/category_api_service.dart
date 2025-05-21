import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/features/store/category_model.dart';
import 'package:http/http.dart' as http;


class MainCategoryApiService {
  final String baseUrl = 'https://pgmart.shop/api/v3/seller/vendor/categories/all';

  Future<PaginatedMainCategories> fetchMainCategories({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PaginatedMainCategories.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load main categories');
    }
  }
}

// class MainCategoryApiService {
//   final String baseUrl = 'https://pgmart.shop/api/v3/seller/vendor/categories/all';

//   Future<List<MainCategory>> fetchMainCategories() async {
//     final response = await http.get(Uri.parse(baseUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse.map((item) => MainCategory.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load main categories');
//     }
//   }
// }