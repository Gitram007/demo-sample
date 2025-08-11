//Sure! Here's a ready-to-use prompt you can save and reuse anytime you want to get this entire step-by-step setup for a Flutter app + Django backend with API integration, export buttons, and next steps guidance:
//
// ---
//
// ### 🔥 **Reusable Prompt for Full Flutter + Django Backend Setup**
//
// > I want to build a **Flutter mobile application** and a **Django backend** to:
// >
// > * Manage **Materials** with name, quantity, unit
// > * Manage **Products**
// > * Map **Materials to Products** with quantity per unit
// > * Log **Production** entries (product, quantity produced, date)
// > * Show **Reports** with filters (product, date range) and export options (CSV & PDF)
// >
// > Please provide:
// >
// > 1. Full **Django backend** code with models, serializers, views, URLs, and instructions to run server.
// > 2. Flutter app UI code with these main screens:
// >
// >    * Material Management
// >    * Product-Material Mapping
// >    * Production Log
// >    * Reports Screen with CSV/PDF export buttons and light theme.
// > 3. Flutter **API service** code to connect with the Django backend endpoints for CRUD operations and fetching reports.
// > 4. Example Flutter code on how to integrate API calls in at least one screen.
// > 5. A brief snippet or instructions on how to implement CSV and PDF export buttons in Flutter.
// > 6. Finally, give me options on **how to proceed next** (e.g., full Flutter integration, deploying backend, adding auth).
// >
// > Please provide everything step-by-step and clearly so I can build the project smoothly.
//
// ---
//
// ### How to proceed (options you can ask for next):
//
// * Provide full Flutter integration with API calls on all screens.
// * Help implement CSV/PDF export functionality in Flutter.
// * Guide me on deploying Django backend (e.g., to Heroku, AWS).
// * Help add user authentication to backend and Flutter app.
// * Generate a ready-to-use GitHub repo with all code.
//
// ---
//
// You can simply copy-paste this prompt whenever you want to get the full working setup or more detailed help on any part!
//
// ---
//
// If you want, I can also package it as a text file for you. Would you like that?


import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/material_screen.dart';
import 'screens/product_screen.dart';
import 'screens/product_mapping_screen.dart';
import 'screens/production_log_screen.dart';
import 'screens/report_screen.dart';

void main() {
  runApp(MaterialTrackerApp());
}

class MaterialTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Tracker',
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/materials': (_) => MaterialScreen(),
        '/product': (_) => ProductScreen(),
        '/mapping': (_) => MappingScreen(),
        '/production': (_) => ProductionLogScreen(),
        '/reports': (_) => ReportScreen(),
      },
    );
  }
}
