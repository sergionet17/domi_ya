// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:menu_app_flutter/data/menus.dart';
import 'package:menu_app_flutter/widgets/menu_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Almuerzos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return MenuCard(menu: menus[index]);
        },
      ),
    );
  }
}
