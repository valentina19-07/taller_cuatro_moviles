import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<Map<String, String>> endpoints = const [
    {"name": "Departments", "endpoint": "Department"},
    {"name": "Presidents", "endpoint": "President"},
    {"name": "Regions", "endpoint": "Region"},
    {"name": "Tourism", "endpoint": "TouristicAttraction"},
  ];

  // 🎯 ICONOS SEGÚN ENDPOINT
  IconData _getIcon(String name) {
    switch (name) {
      case "Departments":
        return Icons.map;
      case "Presidents":
        return Icons.account_balance;
      case "Regions":
        return Icons.public;
      case "Tourism":
        return Icons.place;
      default:
        return Icons.category;
    }
  }

  // 🎨 COLORES DIFERENTES POR CARD
  List<Color> _getGradient(int index) {
    final gradients = [
      [Color(0xFF6366F1), Color(0xFF8B5CF6)], // morado
      [Color(0xFF06B6D4), Color(0xFF3B82F6)], // azul
      [Color(0xFF10B981), Color(0xFF22C55E)], // verde
      [Color(0xFFF59E0B), Color(0xFFEF4444)], // naranja-rojo
    ];
    return gradients[index % gradients.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text(
          "DASHBOARD",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: endpoints.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),

          itemBuilder: (context, index) {
            final item = endpoints[index];

            return GestureDetector(
              onTap: () {
                context.go('/list/${item["endpoint"]}');
              },

              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _getGradient(index),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getIcon(item["name"]!),
                      size: 50,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      item["name"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}