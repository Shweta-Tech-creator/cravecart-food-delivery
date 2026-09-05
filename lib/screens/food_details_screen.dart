import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../data/food_data.dart';
import '../widgets/quantity_selector.dart';
import 'cart_screen.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodItem food;
  final String heroTag;

  const FoodDetailsScreen({
    super.key,
    required this.food,
    this.heroTag = 'details-food',
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final _customFormKey = GlobalKey<FormState>();
  final TextEditingController _cookingNotesController = TextEditingController();

  int _quantity = 1;
  bool _extraCheese = false;
  bool _extraSauce = false;
  bool _includeCutlery = true;
  String _spiceLevel = 'Medium';
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = CartManager.isFavorite(widget.food.id);
  }

  @override
  void dispose() {
    _cookingNotesController.dispose();
    super.dispose();
  }

  double get _extraPrice {
    double extra = 0.0;
    if (_extraCheese) extra += 30.0;
    if (_extraSauce) extra += 20.0;
    return extra;
  }

  double get _calculatedTotal {
    return (widget.food.price + _extraPrice) * _quantity;
  }

  void _handleAddToCart() {
    final List<String> customizations = [];
    if (_extraCheese) customizations.add('Extra Cheese (+₹30)');
    if (_extraSauce) customizations.add('Extra Spicy Sauce (+₹20)');
    if (_includeCutlery) customizations.add('Cutlery included');

    CartManager.addToCart(
      widget.food,
      quantity: _quantity,
      customizations: customizations,
      extraPrice: _extraPrice,
      spiceLevel: _spiceLevel,
      specialNote: _cookingNotesController.text.trim(),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Added $_quantity x ${widget.food.name} to cart!',
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: const Color(0xFFFFAB40),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
        backgroundColor: const Color(0xFF0F172A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Collapsible Image Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFFFF5722),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : const Color(0xFF64748B),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = CartManager.toggleFavorite(widget.food.id);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isFavorite ? '${widget.food.name} added to favorites!' : 'Removed from favorites',
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.heroTag,
                child: Image.network(
                  widget.food.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFFFF3E0),
                    child: const Center(
                      child: Icon(Icons.fastfood, size: 80, color: Color(0xFFFF5722)),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Food Details & Customization Body
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5722).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.food.category,
                          style: const TextStyle(
                            color: Color(0xFFFF5722),
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          border: Border.all(color: Colors.amber.shade200),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.food.rating} (150+ reviews)',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Food Name & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.food.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      Text(
                        '₹${widget.food.price.toInt()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF5722),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Prep Time & Calories Cards
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF5722).withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.access_time_filled, color: Color(0xFFFF5722), size: 18),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Prep Time', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                                  Text(widget.food.prepTime, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF0F172A))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.local_fire_department, color: Colors.orange, size: 18),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Calories', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                                  Text(widget.food.calories, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF0F172A))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'About this dish',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.food.description,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF334155), fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),

                  // Ingredients Chips
                  if (widget.food.ingredients.isNotEmpty) ...[
                    const Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.food.ingredients.map((ingredient) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            ingredient,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Meal Customization & Cooking Preferences
                  const Text(
                    'Customize Your Meal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Form(
                      key: _customFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Spice Level Preference', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A))),
                          const SizedBox(height: 8),
                          Row(
                            children: ['Mild', 'Medium', 'Extra Spicy'].map((spice) {
                              final isSel = _spiceLevel == spice;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  selected: isSel,
                                  avatar: Icon(
                                    spice == 'Mild'
                                        ? Icons.eco_rounded
                                        : (spice == 'Medium' ? Icons.flare_rounded : Icons.local_fire_department_rounded),
                                    size: 14,
                                    color: isSel ? Colors.white : const Color(0xFFFF5722),
                                  ),
                                  label: Text(spice, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSel ? Colors.white : const Color(0xFF0F172A))),
                                  selectedColor: const Color(0xFFFF5722),
                                  backgroundColor: const Color(0xFFF1F5F9),
                                  onSelected: (val) {
                                    if (val) setState(() => _spiceLevel = spice);
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          const Divider(height: 20),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: const Color(0xFFFF5722),
                            title: const Text('Extra Cheese', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A))),
                            subtitle: const Text('+₹30', style: TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w800, fontSize: 12)),
                            value: _extraCheese,
                            onChanged: (val) => setState(() => _extraCheese = val ?? false),
                          ),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: const Color(0xFFFF5722),
                            title: const Text('Extra Spicy Sauce Dip', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A))),
                            subtitle: const Text('+₹20', style: TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w800, fontSize: 12)),
                            value: _extraSauce,
                            onChanged: (val) => setState(() => _extraSauce = val ?? false),
                          ),
                          const Divider(height: 16),
                          // Cooking instructions textfield
                          TextFormField(
                            controller: _cookingNotesController,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                            decoration: InputDecoration(
                              labelText: 'Chef Cooking Instructions (Optional)',
                              labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                              hintText: 'e.g. Less oil, extra oregano, crispy crust',
                              hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                              filled: true,
                              fillColor: const Color(0xFFF8FAFC),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            activeTrackColor: const Color(0xFFFF5722),
                            title: const Text('Include Eco Cutlery', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A))),
                            value: _includeCutlery,
                            onChanged: (val) => setState(() => _includeCutlery = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                      QuantitySelector(
                        quantity: _quantity,
                        iconSize: 20,
                        padding: 8,
                        onIncrement: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        onDecrement: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Add to Cart Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Price', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                  Text(
                    '₹${_calculatedTotal.toInt()}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFF5722),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Add to Cart • ₹${_calculatedTotal.toInt()}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
