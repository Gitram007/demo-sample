import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../models/material_model.dart';
import '../models/product_model.dart';
import '../models/product_material_model.dart';
import '../models/production_log_model.dart';

class ApiService {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  // Materials
  static Future<List<MaterialItem>> getMaterials() async {
    final res = await http.get(Uri.parse('$baseUrl/materials/'));
    print('getMaterials: statusCode=${res.statusCode}');
    print('getMaterials: body=${res.body}');

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body) as List;
      print('getMaterials: decoded list length=${jsonList.length}');
      return jsonList.map((e) => MaterialItem.fromJson(e)).toList();
    } else {
      print('Failed to load materials: ${res.statusCode}');
      throw Exception('Failed to load materials');
    }
  }

  static Future<MaterialItem> createMaterial(MaterialItem m) async {
    final res = await http.post(Uri.parse('$baseUrl/materials/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(m.toJson()));
    return MaterialItem.fromJson(json.decode(res.body));
  }

  static Future<void> deleteMaterial(int id) async {
    await http.delete(Uri.parse('$baseUrl/materials/$id/'));
  }

  // Products
  static Future<List<Product>> getProducts() async {
    final res = await http.get(Uri.parse('$baseUrl/products/'));
    print('getProducts: statusCode=${res.statusCode}');
    print('getProducts: body=${res.body}');

    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body) as List;
      print('getProducts: decoded list length=${jsonList.length}');
      return jsonList.map((e) => Product.fromJson(e)).toList();
    } else {
      print('Failed to load products: ${res.statusCode}');
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> createProduct(Product p) async {
    final res = await http.post(Uri.parse('$baseUrl/products/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(p.toJson()));
    return Product.fromJson(json.decode(res.body));
  }

  static Future<void> deleteProduct(int id) async {
    await http.delete(Uri.parse('$baseUrl/products/$id/'));
  }

  // Mappings
  static Future<List<ProductMaterial>> getMappings() async {
    final res = await http.get(Uri.parse('$baseUrl/mappings/'));
    return (json.decode(res.body) as List)
        .map((e) => ProductMaterial.fromJson(e))
        .toList();
  }

  static Future<ProductMaterial> createMapping(ProductMaterial pm) async {
    final res = await http.post(Uri.parse('$baseUrl/mappings/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pm.toJson()),
    );
    return ProductMaterial.fromJson(json.decode(res.body));
  }

  static Future<void> deleteMapping(int id) async {
    await http.delete(Uri.parse('$baseUrl/mappings/$id/'));
  }

  // Production Logs
  static Future<List<ProductionLog>> getProductions() async {
    final res = await http.get(Uri.parse('$baseUrl/production/'));
    return (json.decode(res.body) as List)
        .map((e) => ProductionLog.fromJson(e))
        .toList();
  }

  static Future<ProductionLog> createProduction(ProductionLog p) async {
    final res = await http.post(Uri.parse('$baseUrl/production/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(p.toJson(productId: p.product.id)));
    return ProductionLog.fromJson(json.decode(res.body));
  }

  static Future<void> deleteProduction(int id) async {
    await http.delete(Uri.parse('$baseUrl/production/$id/'));
  }

  // Reports
  static Future<String> fetchReportCsv({int? productId, String? start, String? end}) async {
    final uri = Uri.parse('$baseUrl/production/report/')
        .replace(queryParameters: {
      if (productId != null) 'product_id': '$productId',
      if (start != null) 'start_date': start,
      if (end != null) 'end_date': end,
      'format': 'csv',
    });
    final res = await http.get(uri);
    return res.body;
  }

  static Future<Uint8List> fetchReportPdf({int? productId, String? start, String? end}) async {
    final uri = Uri.parse('$baseUrl/production/report/')
        .replace(queryParameters: {
      if (productId != null) 'product_id': '$productId',
      if (start != null) 'start_date': start,
      if (end != null) 'end_date': end,
      'format': 'pdf',
    });
    final res = await http.get(uri);
    return res.bodyBytes;
  }
}
