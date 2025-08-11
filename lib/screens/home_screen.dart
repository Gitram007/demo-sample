import 'package:flutter/material.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> screens = [
    {'title': 'Materials', 'route': '/materials'},
    {'title': 'product', 'route': '/product'},
    {'title': 'Product Mapping', 'route': '/mapping'},
    {'title': 'Production Log', 'route': '/production'},
    {'title': 'Reports', 'route': '/reports'},
  ];
  List<dynamic> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    final fetchedNotes = await fetchNotes();
    setState(() {
      notes = fetchedNotes;
    });
  }

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
