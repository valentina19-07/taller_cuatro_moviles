import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailView extends StatelessWidget {
  final dynamic data;

  const DetailView({super.key, this.data});

  // 🧠 Diccionario de traducción
  String traducir(String key) {
    const traducciones = {
      "name": "Nombre",
      "title": "Título",
      "description": "Descripción",
      "region": "Región",
      "department": "Departamento",
      "city": "Ciudad",
      "population": "Población",
      "area": "Área",
      "founded": "Fundación",
      "president": "Presidente",
    };

    return traducciones[key] ?? key;
  }

  // 🧠 Filtrar solo campos importantes
  List<MapEntry<String, dynamic>> filtrarDatos() {
    return data.entries.where((e) {
      return e.value != null &&
             e.value.toString().isNotEmpty &&
             e.key != "id";
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final datosFiltrados = filtrarDatos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle"),

        // 🔙 botón volver
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: datosFiltrados.length,
          itemBuilder: (context, index) {
            final item = datosFiltrados[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(
                  traducir(item.key),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(item.value.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}