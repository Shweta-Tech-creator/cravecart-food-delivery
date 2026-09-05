import 'food_item.dart';

class CartItem {
  final FoodItem food;
  int quantity;
  final List<String> customizations;
  final double extraPrice;
  final String spiceLevel;
  final String specialNote;

  CartItem({
    required this.food,
    this.quantity = 1,
    this.customizations = const [],
    this.extraPrice = 0.0,
    this.spiceLevel = 'Medium',
    this.specialNote = '',
  });

  double get totalPrice => (food.price + extraPrice) * quantity;
}
