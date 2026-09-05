import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../screens/food_listing_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/table_booking_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onRefresh;

  const CustomDrawer({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.fastfood,
                    color: Color(0xFFFF5722),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'CraveCart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Delicious food delivered in minutes',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Member Info Badge
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFCC80)),
            ),
            child: const Row(
              children: [
                Icon(Icons.workspace_premium_rounded, color: Color(0xFFE64A19), size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'CraveCart Gold Member\nFree Express Delivery & Offers',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD84315),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // Navigation Links
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Color(0xFFFF5722)),
            title: const Text('Home', style: TextStyle(fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu, color: Color(0xFFFF5722)),
            title: const Text('Explore Menu', style: TextStyle(fontWeight: FontWeight.w600)),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FoodListingScreen()),
              );
              onRefresh();
            },
          ),
          ListTile(
            leading: Badge(
              isLabelVisible: CartManager.totalItemCount > 0,
              label: Text('${CartManager.totalItemCount}'),
              child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFFF5722)),
            ),
            title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: Text(
              '₹${CartManager.total.toInt()}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF5722)),
            ),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
              onRefresh();
            },
          ),

          ListTile(
            leading: const Icon(Icons.table_restaurant_rounded, color: Color(0xFF059669)),
            title: const Text('Book a Table', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Fine-dine table reservation', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TableBookingScreen()),
              );
              onRefresh();
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_rate_rounded, color: Color(0xFFFFB300)),
            title: const Text('Rate & Review', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Share your food experience', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackScreen()),
              );
              onRefresh();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded, color: Color(0xFF6366F1)),
            title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Thane address & preferences', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              onRefresh();
            },
          ),

          const Divider(),

          // About Dialog Action
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.grey),
            title: const Text('About CraveCart'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Row(
                    children: [
                      Icon(Icons.fastfood, color: Color(0xFFFF5722)),
                      SizedBox(width: 8),
                      Text('About CraveCart'),
                    ],
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CraveCart is a modern Gourmet Food Ordering and Dine-in reservation app built with Flutter and Material 3.',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Features & Highlights:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      SizedBox(height: 4),
                      Text('• Express Doorstep Food Delivery\n• Fine Dine-in Table Reservations\n• Live Order Tracker & Status\n• Verified Customer Reviews & Ratings\n• Instant Promo Codes & Discounts', style: TextStyle(fontSize: 12, height: 1.4)),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close', style: TextStyle(color: Color(0xFFFF5722))),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
