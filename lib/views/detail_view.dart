import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailView extends StatelessWidget {
  final dynamic data;

  const DetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final map = data as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),

      body: ListView(
        children: map.entries.map((e) {
          return ListTile(
            title: Text(e.key),
            subtitle: Text(e.value.toString()),
          );
        }).toList(),
      ),
    );
  }
}