import 'package:flutter/material.dart';
import 'package:menu_app_flutter/data/menus.dart';
import 'package:menu_app_flutter/models/menu.dart';
import 'package:menu_app_flutter/screens/detail_screen.dart';
import 'package:menu_app_flutter/widgets/menu_card.dart';

class HomeScreen extends StatelessWidget {
  final double caloricNeeds;

  const HomeScreen({super.key, required this.caloricNeeds});

  @override
  Widget build(BuildContext context) {
    final MenuService menuService = MenuService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Almuerzos Personalizado'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Menu>>(
        stream: menuService.getMenus(), // Escuchar cambios en Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Cargando...
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los almuerzos'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay almuerzos disponibles'));
          }

          // Filtrar almuerzos según las calorías del usuario
          final filteredMenus = snapshot.data!.where((menu) => menu.calories <= caloricNeeds).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredMenus.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(menu: filteredMenus[index]),
                    ),
                  );
                },
                child: MenuCard(menu: filteredMenus[index]),
              );
            },
          );
        },
      ),
    );
  }
}
