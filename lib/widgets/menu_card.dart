import 'package:flutter/material.dart';
import 'package:menu_app_flutter/models/menu.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          menu.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported, size: 60, color: Colors.grey);
          },
        ),
      ),
      title: Text(menu.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(menu.description),
      trailing: Text(
        '\$${menu.price}',
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
      ),
    );
  }
}
