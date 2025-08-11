import 'package:flutter/material.dart';

class ExportButtons extends StatelessWidget {
  const ExportButtons({Key? key}) : super(key: key);

  void exportCSV(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV export is not implemented yet.')),
    );
  }

  void exportPDF(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF export is not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => exportCSV(context),
          icon: Icon(Icons.file_download),
          label: Text('Export CSV'),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () => exportPDF(context),
          icon: Icon(Icons.picture_as_pdf),
          label: Text('Export PDF'),
        ),
      ],
    );
  }
}
