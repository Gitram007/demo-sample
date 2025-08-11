import '../models/product_model.dart';

class ProductionLog {
  final int? id;
  final Product product;
  final double quantityProduced;
  final String date; // ISO date string

  ProductionLog({this.id, required this.product, required this.quantityProduced, required this.date});

  factory ProductionLog.fromJson(Map<String, dynamic> json) => ProductionLog(
    id: json['id'],
    product: Product.fromJson(json['product']),
    quantityProduced: json['quantity_produced'].toDouble(),
    date: json['date'],
  );

  Map<String, dynamic> toJson({int? productId}) => {
    'product': productId ?? product.id,
    'quantity_produced': quantityProduced,
    'date': date,
  };
}
