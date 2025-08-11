import 'package:flutter/material.dart';

class ProductionLogScreen extends StatefulWidget {
  @override
  _ProductionLogScreenState createState() => _ProductionLogScreenState();
}

class _ProductionLogScreenState extends State<ProductionLogScreen> {
  String? selectedProduct;
  final List<String> products = ['Product A', 'Product B', 'Product C'];

  final TextEditingController qtyController = TextEditingController();

  List<Map<String, dynamic>> productionLogs = [
    {
      'product': 'Product A',
      'quantity': 10,
      'date': DateTime.now().subtract(Duration(days: 1)),
    },
    {
      'product': 'Product B',
      'quantity': 5,
      'date': DateTime.now(),
    },
  ];

  void logProduction() {
    if (selectedProduct == null || qtyController.text.isEmpty) return;

    setState(() {
      productionLogs.add({
        'product': selectedProduct,
        'quantity': int.tryParse(qtyController.text) ?? 0,
        'date': DateTime.now(),
      });
      qtyController.clear();
    });
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Production Log'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select Product'),
                    value: selectedProduct,
                    items: products
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedProduct = val;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity Produced'),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: logProduction,
                  child: Text('Log Production'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Date')),
                  ],
                  rows: productionLogs.map((log) {
                    return DataRow(cells: [
                      DataCell(Text(log['product'])),
                      DataCell(Text(log['quantity'].toString())),
                      DataCell(Text(formatDate(log['date']))),
                    ]);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
