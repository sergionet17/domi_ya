import 'package:flutter/material.dart';
import 'package:menu_app_flutter/data/menus.dart';
import 'package:menu_app_flutter/screens/detail_screen.dart';
import 'package:menu_app_flutter/widgets/menu_card.dart';
import 'package:menu_app_flutter/models/menu.dart';

class HomeScreen extends StatelessWidget {
  final double? caloricNeeds;

  const HomeScreen({super.key, this.caloricNeeds});

  @override
  Widget build(BuildContext context) {
    final menuService = MenuService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Almuerzos'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Menu>>(
        stream: menuService.getMenus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // ⏳ Mostramos un loader mientras carga
          }

          if (snapshot.hasError) {
            print("🔥 Error obteniendo los almuerzos: ${snapshot.error}");
            return const Center(child: Text("Error cargando los almuerzos"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("⚠ No hay almuerzos en la base de datos.");
            return const Center(child: Text("No hay almuerzos disponibles"));
          }

          List<Menu> menus = snapshot.data!;
          print("✅ Almuerzos obtenidos: ${menus.length}");

          return Column(
            children: [
              if (caloricNeeds != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tu requerimiento calórico diario: ${caloricNeeds!.toStringAsFixed(0)} kcal',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(menu: menus[index]),
                          ),
                        );
                      },
                      child: MenuCard(menu: menus[index]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
