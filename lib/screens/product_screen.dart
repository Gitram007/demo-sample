import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_sample/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];
  final TextEditingController nameController = TextEditingController();
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('products');
    if (data != null) {
      List decoded = jsonDecode(data);
      setState(() {
        products = decoded.map((e) => Product.fromJson(e)).toList();
      });
    }
  }

  Future<void> saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List jsonList = products.map((e) => e.toJson()).toList();
    await prefs.setString('products', jsonEncode(jsonList));
  }

  void addOrUpdateProduct() {
    String name = nameController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      if (editingIndex != null) {
        products[editingIndex!] =
            Product(id: products[editingIndex!].id, name: name);
        editingIndex = null;
      } else {
        int newId = DateTime.now().millisecondsSinceEpoch;
        products.add(Product(id: newId, name: name));
      }
      saveProducts();
      nameController.clear();
    });
  }

  void editProduct(int index) {
    setState(() {
      nameController.text = products[index].name;
      editingIndex = index;
    });
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
      saveProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Management')),
      body: Column(
        children: [
          // Product Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: products.asMap().entries.map((entry) {
                  final index = entry.key;
                  final product = entry.value;
                  return DataRow(cells: [
                    DataCell(Text(product.id?.toString() ?? '')),
                    DataCell(Text(product.name)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => editProduct(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteProduct(index),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),

          // Input Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addOrUpdateProduct,
                  child: Text(editingIndex != null ? 'Update' : 'Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
