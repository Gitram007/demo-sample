import 'package:flutter/material.dart';
import 'package:demo_sample/models/product_model.dart';
import 'package:demo_sample/services/api_service_local.dart';

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
    final fetchedProducts = await ApiServiceLocal.getProducts();
    setState(() {
      products = fetchedProducts;
    });
  }

  void addOrUpdateProduct() async {
    String name = nameController.text.trim();
    if (name.isEmpty) return;

    if (editingIndex != null) {
      products[editingIndex!] =
          Product(id: products[editingIndex!].id, name: name);
    } else {
      int newId = DateTime.now().millisecondsSinceEpoch;
      products.add(Product(id: newId, name: name));
    }

    await ApiServiceLocal.saveProducts(products);
    nameController.clear();
    setState(() {
      editingIndex = null;
    });
    loadProducts(); // Refresh the list
  }

  void editProduct(int index) {
    setState(() {
      nameController.text = products[index].name;
      editingIndex = index;
    });
  }

  void deleteProduct(int index) async {
    products.removeAt(index);
    await ApiServiceLocal.saveProducts(products);
    loadProducts(); // Refresh the list
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
