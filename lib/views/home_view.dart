import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DASHBOARD")),

      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _card(context, "Departments", "Department"),
          _card(context, "Regions", "Region"),
          _card(context, "Presidents", "President"),
          _card(context, "Natural Areas", "NaturalArea"),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, String title, String endpoint) {
    return GestureDetector(
      onTap: () {
        context.push('/list/$endpoint');
      },
      child: Card(
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}