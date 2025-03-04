// widgets/menu_card.dart
import 'package:flutter/material.dart';
import 'package:menu_app_flutter/models/menu.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            menu.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(menu.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(menu.description),
        trailing: Text('\$${menu.price}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
        onTap: () {
          // Navegar a la pantalla de detalles (pendiente de agregar)
        },
      ),
    );
  }
}