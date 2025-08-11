import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../models/material_model.dart';
import '../models/product_material_model.dart';


class ApiServiceLocal {
  static const String _productsKey = 'products';
  static const String _mappingsKey = 'mappings';

  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_productsKey);

    if (data != null) {
      final List decoded = jsonDecode(data);
      return decoded.map((e) => Product.fromJson(e)).toList();
    } else {
      // Load from asset, save to prefs, then return
      final jsonString = await rootBundle.loadString('assets/products.json');
      await prefs.setString(_productsKey, jsonString);
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((json) => Product.fromJson(json)).toList();
    }
  }

  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final List jsonList = products.map((e) => e.toJson()).toList();
    await prefs.setString(_productsKey, jsonEncode(jsonList));
  }

  static Future<List<MaterialItem>> getMaterials() async {
    final jsonString = await rootBundle.loadString('assets/materials.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => MaterialItem.fromJson(json)).toList();
  }

  static Future<List<ProductMaterial>> getMappings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_mappingsKey);
    if (data != null) {
      final List decoded = jsonDecode(data);
      return decoded.map((e) => ProductMaterial.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> createMapping(ProductMaterial pm) async {
    final List<ProductMaterial> mappings = await getMappings();
    mappings.add(pm);
    await _saveMappings(mappings);
  }

  static Future<void> deleteMapping(int id) async {
    final List<ProductMaterial> mappings = await getMappings();
    mappings.removeWhere((m) => m.id == id);
    await _saveMappings(mappings);
  }

  static Future<void> _saveMappings(List<ProductMaterial> mappings) async {
    final prefs = await SharedPreferences.getInstance();
    final List jsonList = mappings.map((e) => e.toJson()).toList();
    await prefs.setString(_mappingsKey, jsonEncode(jsonList));
  }
}
