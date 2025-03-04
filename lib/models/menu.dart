class Menu {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> ingredients;
  final int calories;

  Menu({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.ingredients,
    required this.calories,
  });

  factory Menu.fromFirestore(Map<String, dynamic> data) {
    return Menu(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      calories: data['calories'] ?? 0,
    );
  }
}
