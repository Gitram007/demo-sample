import 'package:flutter/material.dart';

class SomeDynamicScreen extends StatelessWidget {
  final String? data;
  const SomeDynamicScreen({this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Screen')),
      body: Center(child: Text('Data: ${data ?? "No data"}')),
    );
  }
}
