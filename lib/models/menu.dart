import 'package:menu_app_flutter/models/ingredient.dart';

class Menu {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<Ingredient> ingredients;
  final int calories; // 🔥 Asegurar que este campo esté aquí

  Menu({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.ingredients,
    required this.calories, // 🔥 Ahora el parámetro está definido
  });

  /// 🔥 Método para calcular el total de calorías sumando los ingredientes
  int totalCalories() {
    return ingredients.fold(0, (total, ingredient) => total + ingredient.caloriesPerUnit);
  }

  /// 🔥 Convertir desde Firestore
  factory Menu.fromFirestore(Map<String, dynamic> data) {
    return Menu(
      name: data['name'] as String,
      description: data['description'] as String,
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'] as String,
      ingredients: (data['ingredients'] as List)
          .map((ingredient) => Ingredient.fromFirestore(ingredient))
          .toList(),
      calories: (data['calories'] as num).toInt(), // 🔥 Asegurar que se obtiene de Firestore
    );
  }

  /// 🔥 Convertir a Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'ingredients': ingredients.map((ingredient) => ingredient.toFirestore()).toList(),
      'calories': calories, // 🔥 Asegurar que se guarda correctamente
    };
  }
}
