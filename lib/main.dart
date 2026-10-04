import 'package:flutter/material.dart';
import 'menu/menu_librerias.dart';


void main() {
  runApp(const GraficosApp());
}

class GraficosApp extends StatelessWidget {
  const GraficosApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller de Graficos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Color(0xFF3F51B5)),
      ),
      home: const MenuLibrerias(),
    );
  }
}

