import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../data/food_data.dart';
import '../widgets/food_card.dart';
import '../widgets/category_chip.dart';
import 'cart_screen.dart';

class FoodListingScreen extends StatefulWidget {
  final String initialCategory;

  const FoodListingScreen({
    super.key,
    this.initialCategory = 'All',
  });

  @override
  State<FoodListingScreen> createState() => _FoodListingScreenState();
}

class _FoodListingScreenState extends State<FoodListingScreen> {
  late String _selectedCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter food items based on selected category and search keyword
  List<FoodItem> get _filteredFoods {
    return FoodData.foodList.where((food) {
      final matchesCategory = _selectedCategory == 'All' || food.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          food.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          food.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          food.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredFoods;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      appBar: AppBar(
        title: const Text(
          'Explore Menu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2D3142),
        elevation: 0,
        centerTitle: true,
        actions: [
          // Cart Icon with Badge
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Badge(
                isLabelVisible: CartManager.totalItemCount > 0,
                label: Text('${CartManager.totalItemCount}'),
                backgroundColor: const Color(0xFFFF5722),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Header Container
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                // Search TextField
                TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search food, pizza, burgers...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFFF5722)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF5F5F7),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Category Chips List
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: FoodData.categories.length,
                    itemBuilder: (context, index) {
                      final cat = FoodData.categories[index];
                      final icon = FoodData.categoryIcons[cat] ?? Icons.restaurant_rounded;
                      return CategoryChip(
                        label: cat,
                        icon: icon,
                        isSelected: _selectedCategory == cat,
                        onTap: () {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Search Summary Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedCategory == 'All' ? 'All Items' : '$_selectedCategory Items',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3142),
                  ),
                ),
                Text(
                  '${filteredList.length} items found',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Food Grid or Empty State
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'No food items found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try changing the category or search keyword',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                                _selectedCategory = 'All';
                              });
                            },
                            icon: const Icon(Icons.refresh, size: 16),
                            label: const Text('Reset Filters'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF5722),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final food = filteredList[index];
                      return FoodCard(
                        food: food,
                        heroPrefix: 'listing',
                        onCartUpdated: () {
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
