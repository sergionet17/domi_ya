import 'package:flutter/material.dart';
import 'package:menu_app_flutter/models/menu.dart';

class DetailScreen extends StatelessWidget {
  final Menu menu;
  const DetailScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(menu.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Ingredientes:',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...menu.ingredients.map((ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• $ingredient', style: const TextStyle(fontSize: 16)),
              )),
              const SizedBox(height: 20),
              Text(
                'Calorías: ${menu.calories} kcal',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 20),
              Text(
                menu.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
