import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/material_model.dart';
import '../models/product_material_model.dart';
import '../services/api_service_local.dart';

class MappingScreen extends StatefulWidget {
  @override
  _MappingScreenState createState() => _MappingScreenState();
}

class _MappingScreenState extends State<MappingScreen> {
  List<Product> products = [];
  List<MaterialItem> materials = [];
  List<ProductMaterial> mappings = [];

  Product? selectedProduct;
  MaterialItem? selectedMaterial;
  TextEditingController qtyController = TextEditingController();

  bool isLoading = true; // show loading until data fetched

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  Future<void> loadAll() async {
    try {
      final fetchedProducts = await ApiService.getProducts();
      final fetchedMaterials = await ApiService.getMaterials();
      final fetchedMappings = await ApiService.getMappings();

      setState(() {
        products = fetchedProducts;
        materials = fetchedMaterials;
        mappings = fetchedMappings;

        // Initialize selected values if not selected yet
        if (products.isNotEmpty) selectedProduct = products[0];
        if (materials.isNotEmpty) selectedMaterial = materials[0];

        isLoading = false;
      });

      print('Loaded products: ${products.length}');
      print('Loaded materials: ${materials.length}');
    } catch (e) {
      setState(() => isLoading = false);
      print('Error loading data: $e');
      // handle error appropriately
    }
  }

  void addMapping() async {
    final quantity = double.tryParse(qtyController.text);
    if (selectedProduct != null &&
        selectedMaterial != null &&
        quantity != null) {
      await ApiService.createMapping(ProductMaterial(
        product: selectedProduct!,
        material: selectedMaterial!,
        quantityPerUnit: quantity,
      ));
      qtyController.clear();
      loadAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product–Material Mapping')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: DropdownButton<Product>(
                      isExpanded: true,
                      hint: Text('Select Product'),
                      value: selectedProduct,
                      items: products
                          .map<DropdownMenuItem<Product>>((p) =>
                          DropdownMenuItem<Product>(
                            value: p,
                            child: Text(p.name),
                          ))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => selectedProduct = v),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: 200,
                    child: DropdownButton<MaterialItem>(
                      isExpanded: true,
                      hint: Text('Select Material'),
                      value: selectedMaterial,
                      items: materials
                          .map<DropdownMenuItem<MaterialItem>>((m) =>
                          DropdownMenuItem<MaterialItem>(
                            value: m,
                            child: Text(m.name),
                          ))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => selectedMaterial = v),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: qtyController,
                      decoration: InputDecoration(labelText: 'Qty/unit'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(onPressed: addMapping, child: Text('Add')),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mappings.length,
              itemBuilder: (_, i) {
                final m = mappings[i];
                return ListTile(
                  title: Text('${m.product.name} → ${m.material.name}'),
                  subtitle: Text('${m.quantityPerUnit} per unit'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await ApiService.deleteMapping(m.id!);
                      loadAll();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
