// class Product {
//   final String name;
//
//   Product({required this.name});
// }
//
// class ProductMaterialMap {
//   final String materialName;
//   final double quantityPerUnit;
//   final String unit;
//
//   ProductMaterialMap({
//     required this.materialName,
//     required this.quantityPerUnit,
//     required this.unit,
//   });
// }

class Product {
  final int? id;
  final String name;

  Product({this.id, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Product && runtimeType == other.runtimeType && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
