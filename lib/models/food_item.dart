class FoodItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final double rating;
  final String image;
  final List<String> ingredients;
  final String calories;
  final String prepTime;
  final bool isPopular;
  final bool isVeg;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    this.ingredients = const [],
    this.calories = '280 kcal',
    this.prepTime = '20-25 min',
    this.isPopular = false,
    this.isVeg = true,
  });
}
