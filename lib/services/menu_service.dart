import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu.dart';
import 'package:menu_app_flutter/models/ingredient.dart';

class MenuService {
  final CollectionReference menuCollection =
  FirebaseFirestore.instance.collection('almuerzos');

  Future<void> addMenus() async {
    List<Menu> menus = [
      Menu(
        name: 'Almuerzo Ejecutivo',
        description: 'Arroz, carne asada, ensalada y jugo natural.',
        price: 12000,
        imageUrl: 'https://source.unsplash.com/300x200/?lunch,food',
        ingredients: [
          Ingredient(name: 'Arroz', caloriesPerUnit: 200),
          Ingredient(name: 'Carne Asada', caloriesPerUnit: 250),
          Ingredient(name: 'Ensalada', caloriesPerUnit: 50),
          Ingredient(name: 'Jugo Natural', caloriesPerUnit: 100),
        ],
        calories: 600,
      ),
      Menu(
        name: 'Plato Vegetariano',
        description: 'Quinua, ensalada, tofu y jugo natural.',
        price: 15000,
        imageUrl: 'https://source.unsplash.com/300x200/?vegetarian,food',
        ingredients: [
          Ingredient(name: 'Quinua', caloriesPerUnit: 220),
          Ingredient(name: 'Tofu', caloriesPerUnit: 180),
          Ingredient(name: 'Ensalada', caloriesPerUnit: 40),
          Ingredient(name: 'Jugo Natural', caloriesPerUnit: 100),
        ],
        calories: 450,
      ),
    ];

    for (var menu in menus) {
      await menuCollection.add(menu.toFirestore());
    }
    print("✅ Almuerzos agregados correctamente.");
  }
}
