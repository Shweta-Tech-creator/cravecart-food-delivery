import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';

class FoodData {
  static const List<String> categories = [
    'All',
    'Pizza',
    'Burger',
    'Indian',
    'Chinese',
    'Desserts',
    'Drinks',
  ];

  static const Map<String, IconData> categoryIcons = {
    'All': Icons.restaurant_menu_rounded,
    'Pizza': Icons.local_pizza_rounded,
    'Burger': Icons.lunch_dining_rounded,
    'Indian': Icons.dinner_dining_rounded,
    'Chinese': Icons.ramen_dining_rounded,
    'Desserts': Icons.cake_rounded,
    'Drinks': Icons.local_bar_rounded,
  };

  static const List<FoodItem> foodList = [
    FoodItem(
      id: '1',
      name: 'Truffle Mushroom Pizza',
      category: 'Pizza',
      description:
          'Artisanal hand-stretched sourdough crust with wild shiitake mushrooms, truffle oil, roasted garlic puree, and fresh buffalo mozzarella.',
      price: 299.0,
      rating: 4.9,
      image:
          'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Wild Mushrooms', 'White Truffle Oil', 'Buffalo Mozzarella', 'San Marzano Sauce', 'Sourdough'],
      calories: '310 kcal',
      prepTime: '20-25 min',
      isPopular: true,
      isVeg: true,
    ),
    FoodItem(
      id: '2',
      name: 'Smoked Jalapeño Burger',
      category: 'Burger',
      description:
          'Charcoal-grilled gourmet patty topped with oak-smoked cheddar cheese, house pickled jalapeños, crispy onion rings, and chipotle aioli on a brioche bun.',
      price: 219.0,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Grilled Patty', 'Smoked Cheddar', 'Pickled Jalapeños', 'Chipotle Aioli', 'Brioche Bun'],
      calories: '420 kcal',
      prepTime: '15-20 min',
      isPopular: true,
      isVeg: false,
    ),
    FoodItem(
      id: '3',
      name: 'Dhaba Paneer Tikka',
      category: 'Indian',
      description:
          'Organic Malai paneer marinated with Kashmiri red chilies, mustard oil, hung curd, and stone-ground spices, roasted in clay tandoor.',
      price: 249.0,
      rating: 4.9,
      image:
          'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Malai Paneer', 'Kashmiri Masala', 'Capsicum & Onions', 'Mint Dip'],
      calories: '290 kcal',
      prepTime: '20-25 min',
      isPopular: true,
      isVeg: true,
    ),
    FoodItem(
      id: '4',
      name: 'Szechuan Chilli Noodles',
      category: 'Chinese',
      description:
          'Signature wok-fried artisanal noodles tossed with crispy garden bok choy, scallions, roasted peanuts, and fragrant Szechuan chili crunch.',
      price: 189.0,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Wheat Noodles', 'Bok Choy', 'Szechuan Pepper', 'Toasted Sesame', 'Garlic Soy'],
      calories: '330 kcal',
      prepTime: '15-20 min',
      isPopular: true,
      isVeg: true,
    ),
    FoodItem(
      id: '5',
      name: 'Belgian Lava Brownie',
      category: 'Desserts',
      description:
          '70% single-origin Belgian dark chocolate brownie with molten hazelnut core, served with salted caramel drizzle and roasted almond flakes.',
      price: 169.0,
      rating: 4.9,
      image:
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=800&q=80',
      ingredients: ['70% Belgian Chocolate', 'Hazelnut Praline', 'Salted Caramel', 'Almond Flakes'],
      calories: '360 kcal',
      prepTime: '10-15 min',
      isPopular: true,
      isVeg: true,
    ),
    FoodItem(
      id: '6',
      name: 'Vanilla Cold Brew',
      category: 'Drinks',
      description:
          '18-hour steeped Arabica cold brew infused with organic Madagascar vanilla, shaken over ice with oat milk foam.',
      price: 139.0,
      rating: 4.6,
      image:
          'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Arabica Cold Brew', 'Madagascar Vanilla', 'Oat Milk Cream', 'Crushed Ice'],
      calories: '180 kcal',
      prepTime: '5-10 min',
      isPopular: true,
      isVeg: true,
    ),
    FoodItem(
      id: '7',
      name: 'Roasted Garlic Burrata Pizza',
      category: 'Pizza',
      description:
          'Creamy artisanal burrata ball over slow-cooked pomodoro sauce, roasted garlic cloves, fresh arugula, and balsamic reduction.',
      price: 329.0,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Fresh Burrata', 'Pomodoro Sauce', 'Arugula', 'Balsamic Glaze'],
      calories: '340 kcal',
      prepTime: '20-25 min',
      isPopular: false,
      isVeg: true,
    ),
    FoodItem(
      id: '8',
      name: 'Truffle Parmesan Fries',
      category: 'Burger',
      description:
          'Hand-cut Yukon gold potatoes fried to golden perfection, tossed in white truffle oil, grated aged parmesan, and fresh rosemary.',
      price: 149.0,
      rating: 4.7,
      image:
          'https://images.unsplash.com/photo-1576107232684-1279f3908594?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Yukon Gold Potatoes', 'Aged Parmesan', 'Truffle Oil', 'Rosemary Salt'],
      calories: '310 kcal',
      prepTime: '10-15 min',
      isPopular: false,
      isVeg: true,
    ),
    FoodItem(
      id: '9',
      name: 'Butter Paneer Makhani',
      category: 'Indian',
      description:
          'Velvety smooth cashew-tomato gravy simmered with unsalted churned butter, char-grilled paneer cubes, and aromatic kasuri methi.',
      price: 279.0,
      rating: 4.9,
      image:
          'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Paneer Cubes', 'Cashew Cream', 'Churned Butter', 'Tomato Concasse'],
      calories: '390 kcal',
      prepTime: '25-30 min',
      isPopular: false,
      isVeg: true,
    ),
    FoodItem(
      id: '10',
      name: 'Matcha Mango Boba',
      category: 'Drinks',
      description:
          'Uji Japanese ceremonial green tea layered over fresh Alphonso mango purée and brown sugar tapioca boba pearls.',
      price: 169.0,
      rating: 4.8,
      image:
          'https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=800&q=80',
      ingredients: ['Uji Matcha', 'Alphonso Mango Purée', 'Brown Sugar Boba', 'Soy Milk'],
      calories: '220 kcal',
      prepTime: '5-10 min',
      isPopular: false,
      isVeg: true,
    ),
  ];
}

class CartManager {
  static final List<CartItem> items = [];
  static final Set<String> favoriteIds = {};
  
  // Coupon state
  static String? appliedCouponCode;
  static double discountAmount = 0.0;

  static void addToCart(
    FoodItem food, {
    int quantity = 1,
    List<String> customizations = const [],
    double extraPrice = 0.0,
    String spiceLevel = 'Medium',
    String specialNote = '',
  }) {
    final customKey = customizations.join(',') + spiceLevel + specialNote;
    final existingIndex = items.indexWhere((item) =>
        item.food.id == food.id &&
        item.customizations.join(',') + item.spiceLevel + item.specialNote == customKey);

    if (existingIndex != -1) {
      items[existingIndex].quantity += quantity;
    } else {
      items.add(
        CartItem(
          food: food,
          quantity: quantity,
          customizations: List.from(customizations),
          extraPrice: extraPrice,
          spiceLevel: spiceLevel,
          specialNote: specialNote,
        ),
      );
    }
  }

  static void removeFromCart(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
    if (items.isEmpty) {
      removeCoupon();
    }
  }

  static void increaseQuantity(int index) {
    if (index >= 0 && index < items.length) {
      items[index].quantity++;
    }
  }

  static void decreaseQuantity(int index) {
    if (index >= 0 && index < items.length) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      } else {
        items.removeAt(index);
      }
    }
    if (items.isEmpty) {
      removeCoupon();
    }
  }

  static void clearCart() {
    items.clear();
    removeCoupon();
  }

  static int get totalItemCount {
    int count = 0;
    for (var item in items) {
      count += item.quantity;
    }
    return count;
  }

  static double get subtotal {
    double sum = 0.0;
    for (var item in items) {
      sum += item.totalPrice;
    }
    return sum;
  }

  static double get deliveryFee {
    return items.isEmpty ? 0.0 : 40.0;
  }

  // Coupon Logic
  static bool applyCoupon(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'CRAVECART50' || cleanCode == 'TASTY50') {
      appliedCouponCode = cleanCode;
      discountAmount = 50.0;
      return true;
    } else if (cleanCode == 'WELCOME20' || cleanCode == 'CRAVE20') {
      appliedCouponCode = cleanCode;
      discountAmount = (subtotal * 0.20).clamp(0, 100);
      return true;
    }
    return false;
  }

  static void removeCoupon() {
    appliedCouponCode = null;
    discountAmount = 0.0;
  }

  static double get total {
    if (items.isEmpty) return 0.0;
    final discounted = subtotal - discountAmount;
    return (discounted < 0 ? 0 : discounted) + deliveryFee;
  }

  static bool toggleFavorite(String foodId) {
    if (favoriteIds.contains(foodId)) {
      favoriteIds.remove(foodId);
      return false;
    } else {
      favoriteIds.add(foodId);
      return true;
    }
  }

  static bool isFavorite(String foodId) {
    return favoriteIds.contains(foodId);
  }
}
