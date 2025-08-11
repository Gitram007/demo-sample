import 'package:flutter/material.dart';
import '../widgets/export_button.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedProduct;
  DateTimeRange? dateRange;

  final List<String> products = ['Product A', 'Product B', 'Product C'];

  // Sample data simulating material usage in reports
  final List<Map<String, dynamic>> reportData = [
    {
      'material': 'Steel',
      'totalUsed': 150.0,
      'usedInProducts': 'Product A, Product B',
      'unit': 'kg',
    },
    {
      'material': 'Wood',
      'totalUsed': 80.0,
      'usedInProducts': 'Product A',
      'unit': 'm³',
    },
  ];

  void pickDateRange() async {
    DateTime now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      initialDateRange: dateRange,
    );
    if (picked != null) {
      setState(() {
        dateRange = picked;
      });
    }
  }

  String formatDate(DateTime? d) {
    if (d == null) return '';
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  void generateReport() {
    // Placeholder for report generation logic.
    // For now, it just refreshes the UI with static data.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report generated (static data)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Usage Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filters
            Row(
              children: [
                Expanded(
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
                SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: pickDateRange,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Select Date Range',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(dateRange == null
                          ? 'Choose date range'
                          : '${formatDate(dateRange!.start)} - ${formatDate(dateRange!.end)}'),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: generateReport,
                  child: Text('Generate'),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Report Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Material')),
                    DataColumn(label: Text('Total Used')),
                    DataColumn(label: Text('Used In Products')),
                    DataColumn(label: Text('Unit')),
                  ],
                  rows: reportData.map((row) {
                    return DataRow(cells: [
                      DataCell(Text(row['material'])),
                      DataCell(Text(row['totalUsed'].toString())),
                      DataCell(Text(row['usedInProducts'])),
                      DataCell(Text(row['unit'])),
                    ]);
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Export Buttons
            ExportButtons(),
          ],
        ),
      ),
    );
  }
}
