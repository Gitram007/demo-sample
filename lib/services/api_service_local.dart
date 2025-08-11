import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/product_model.dart';
import '../models/material_model.dart';
import '../models/product_material_model.dart';


class ApiService {
  static Future<List<Product>> getProducts() async {
    final jsonString = await rootBundle.loadString('assets/products.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => Product.fromJson(json)).toList();
  }

  static Future<List<MaterialItem>> getMaterials() async {
    final jsonString = await rootBundle.loadString('assets/materials.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => MaterialItem.fromJson(json)).toList();
  }

  static Future<List<ProductMaterial>> getMappings() async {
    // You can either keep mappings in memory or create a mappings.json file
    return [];
  }

  static Future<void> createMapping(ProductMaterial pm) async {
    // This won't persist unless you write to local storage or a DB
    // For now, simulate success
    return;
  }

  static Future<void> deleteMapping(int id) async {
    return;
  }
}
