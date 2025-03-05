class Ingredient {
  final String name;
  final int caloriesPerUnit;

  Ingredient({required this.name, required this.caloriesPerUnit});

  /// 🔥 Convertir de Firestore a un objeto `Ingredient`
  factory Ingredient.fromFirestore(Map<String, dynamic> data) {
    return Ingredient(
      name: data['name'] as String,
      caloriesPerUnit: (data['caloriesPerUnit'] as num).toInt(),
    );
  }

  /// 🔥 Convertir un objeto `Ingredient` a Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'caloriesPerUnit': caloriesPerUnit,
    };
  }
}
