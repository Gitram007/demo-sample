import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaterialScreen extends StatefulWidget {
  @override
  _MaterialScreenState createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  List<Map<String, dynamic>> materials = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  int? editingIndex;

  @override
  void initState() {
    super.initState();
    loadMaterials();
  }

  // Load from SharedPreferences
  Future<void> loadMaterials() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('materials');
    if (data != null) {
      setState(() {
        materials = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  // Save to SharedPreferences
  Future<void> saveMaterials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('materials', jsonEncode(materials));
  }

  void addOrUpdateMaterial() {
    String name = nameController.text.trim();
    String qtyText = qtyController.text.trim();
    String unit = unitController.text.trim();

    if (name.isEmpty || qtyText.isEmpty || unit.isEmpty) return;

    double? quantity = double.tryParse(qtyText);
    if (quantity == null) return;

    final newMaterial = {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };

    setState(() {
      if (editingIndex != null) {
        materials[editingIndex!] = newMaterial;
        editingIndex = null;
      } else {
        materials.add(newMaterial);
      }
      saveMaterials();
      nameController.clear();
      qtyController.clear();
      unitController.clear();
    });
  }

  void editMaterial(int index) {
    final material = materials[index];
    nameController.text = material['name'];
    qtyController.text = material['quantity'].toString();
    unitController.text = material['unit'];
    setState(() {
      editingIndex = index;
    });
  }

  void deleteMaterial(int index) {
    setState(() {
      materials.removeAt(index);
      saveMaterials();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material Management')),
      body: Column(
        children: [
          // Material Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Material Name')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Unit')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: materials.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> material = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text(material['name'])),
                      DataCell(Text(material['quantity'].toString())),
                      DataCell(Text(material['unit'])),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => editMaterial(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteMaterial(index),
                          ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          // Form to Add/Edit
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Material Name'),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity'),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: TextField(
                    controller: unitController,
                    decoration: InputDecoration(labelText: 'Unit'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addOrUpdateMaterial,
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
