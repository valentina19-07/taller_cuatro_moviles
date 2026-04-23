import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:go_router/go_router.dart';

class ListViewScreen extends StatefulWidget {
  final String endpoint;

  const ListViewScreen({super.key, required this.endpoint});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final ApiService api = ApiService();
  late Future<List<dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = api.getData(widget.endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(
          widget.endpoint.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (context, snapshot) {

          // 🔄 CARGANDO
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ ERROR REAL
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 📦 VALIDACIÓN DE DATOS
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No hay datos disponibles",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final item = data[i] as Map;

              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3B82F6)),
                ),

                child: ListTile(
                  title: Text(
                    _getTitle(item),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    _getSubtitle(item),
                    style: const TextStyle(color: Colors.white70),
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),

                  onTap: () {
                    context.push('/detail', extra: item);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // 🧠 TÍTULO DINÁMICO (NO ROMPE ENDPOINTS)
  String _getTitle(Map item) {
    return item['name'] ??
        item['title'] ??
        item['city'] ??
        item['department'] ??
        item['region'] ??
        'Sin nombre';
  }

  // 🧠 SUBTÍTULO DINÁMICO
  String _getSubtitle(Map item) {
    if (item['population'] != null) {
      return "Población: ${item['population']}";
    }
    if (item['description'] != null) {
      return item['description'];
    }
    if (item['region'] != null) {
      return "Región: ${item['region']}";
    }

    return "Ver más información";
  }
}