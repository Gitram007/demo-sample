import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> screens = [
    {'title': 'Materials', 'route': '/materials'},
    {'title': 'product', 'route': '/product'},
    {'title': 'Product Mapping', 'route': '/mapping'},
    {'title': 'Production Log', 'route': '/production'},
    {'title': 'Reports', 'route': '/reports'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material Tracker')),
      body: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final screen = screens[index];
          return ListTile(
            title: Text(screen['title']),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, screen['route']);
            },
          );
        },
      ),
    );
  }
}
