
class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons});

    
    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'category': category.name,
      'availableAddons': availableAddons.map((addon) => addon.toMap()).toList()
    };
  }

   factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imagePath: map['imagePath'] ?? '',
      price: (map['price'] as num).toDouble(), 
      category: FoodCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => FoodCategory.outros,
      ),
      availableAddons: (map['availableAddons'] as List<dynamic>?)
              ?.map((addon) => Addon.fromMap(addon))
              .toList() ??
          [],
    );
  }
}

enum FoodCategory {
  hamburgers,
  // saladas,
  acompanhamentos,
  sobremesas,
  bebidas,
  pizzas,
  outros
}

class Addon {
  String name;
  double price;

  Addon({required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

   factory Addon.fromMap(Map<String, dynamic> map) {
    return Addon(
      name: map['name'] ?? '',
      price: (map['price'] as num).toDouble(), 
    );
  }
}