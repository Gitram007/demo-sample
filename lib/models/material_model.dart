// class MaterialItem {
//   final String name;
//   final double quantity;
//   final String unit;
//
//   MaterialItem({
//     required this.name,
//     required this.quantity,
//     required this.unit,
//   });
//
//   factory MaterialItem.fromJson(Map<String, dynamic> json) {
//     return MaterialItem(
//         unit: json['unit'],
//         name: json['name'],
//         quantity: json['quantity']
//     );
//   }
//
//   Map<String, dynamic> toJson() =>
//       {
//         'unit': unit,
//         'name': name,
//         'quantity': quantity
//       };
// }

class MaterialItem {
  final int? id;
  final String name;
  final double quantity;
  final String unit;

  MaterialItem({this.id, required this.name, required this.quantity, required this.unit});

  factory MaterialItem.fromJson(Map<String, dynamic> json) => MaterialItem(
    id: json['id'],
    name: json['name'],
    quantity: json['quantity'].toDouble(),
    unit: json['unit'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'unit': unit,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is MaterialItem && runtimeType == other.runtimeType && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
