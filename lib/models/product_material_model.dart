import '../models/material_model.dart';
import '../models/product_model.dart';

class ProductMaterial {
  final int? id;
  final Product product;
  final MaterialItem material;
  final double quantityPerUnit;

  ProductMaterial({
    this.id,
    required this.product,
    required this.material,
    required this.quantityPerUnit,
  });

  /// Factory to create from full JSON (with nested objects)
  factory ProductMaterial.fromJson(Map<String, dynamic> json) {
    return ProductMaterial(
      id: json['id'],
      product: Product.fromJson(json['product']),
      material: MaterialItem.fromJson(json['material']),
      quantityPerUnit: (json['quantity_per_unit'] as num).toDouble(),
    );
  }

  /// To JSON for sending to API (IDs only)
  Map<String, dynamic> toJson() => {
    'product': product.id,
    'material': material.id,
    'quantity_per_unit': quantityPerUnit,
  };

  /// For debugging/logging
  @override
  String toString() {
    return 'Mapping(id: $id, product: ${product.name}, material: ${material.name}, qtyPerUnit: $quantityPerUnit)';
  }

  /// Equality override (required for DropdownButton & comparisons)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductMaterial &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
