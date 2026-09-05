import 'dart:math';
import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/cart_item.dart';
import '../widgets/quantity_selector.dart';
import 'food_listing_screen.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _couponFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();

  String _deliverySlot = 'Standard (30-40 mins)';
  String _paymentMethod = 'Cash on Delivery';
  bool _saveDetails = true;
  String? _couponMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  void _handleApplyCoupon() {
    final code = _couponController.text.trim();
    if (code.isEmpty) {
      setState(() {
        _couponMessage = 'Please enter a coupon code';
      });
      return;
    }

    final success = CartManager.applyCoupon(code);
    setState(() {
      if (success) {
        _couponMessage = 'Coupon "$code" applied successfully! Saved ₹${CartManager.discountAmount.toInt()}';
      } else {
        _couponMessage = 'Invalid code. Try "CRAVECART50" or "WELCOME20"';
      }
    });
  }

  void _handlePlaceOrder() {
    if (_formKey.currentState!.validate()) {
      final orderId = '#CC-${10000 + Random().nextInt(90000)}';
      final customerName = _nameController.text.trim();
      final phoneNumber = _phoneController.text.trim();
      final fullAddress = '${_addressController.text.trim()}, PIN: ${_pincodeController.text.trim()}';
      final totalAmount = CartManager.total;

      final List<CartItem> orderedItemsList = List.from(CartManager.items);

      CartManager.clearCart();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            orderId: orderId,
            customerName: customerName,
            phoneNumber: phoneNumber,
            deliveryAddress: fullAddress,
            paymentMethod: _paymentMethod,
            totalAmount: totalAmount,
            orderedItems: orderedItemsList,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Please fill all required delivery details correctly'),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager.items;
    final isCartEmpty = cartItems.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'My Cart & Checkout',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF0F172A)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        centerTitle: true,
        actions: [
          if (!isCartEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.red),
              tooltip: 'Clear Cart',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    title: const Text('Clear Cart?'),
                    content: const Text('Are you sure you want to remove all items from your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            CartManager.clearCart();
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Clear', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: isCartEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart Items List
                  _buildCartItemsCard(cartItems),
                  const SizedBox(height: 18),

                  // Coupon & Promo Code Form
                  _buildCouponFormCard(),
                  const SizedBox(height: 18),

                  // Bill Breakdown Card
                  _buildBillSummaryCard(),
                  const SizedBox(height: 20),

                  // Delivery Form Card
                  _buildDeliveryFormCard(),
                  const SizedBox(height: 20),

                  // Payment Method Selection Card
                  _buildPaymentSelectionCard(),
                  const SizedBox(height: 24),

                  // Place Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _handlePlaceOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            'Place Order • ₹${CartManager.total.toInt()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF3E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 68,
                color: Color(0xFFFF5722),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore our curated menu and add delicious artisanal dishes!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FoodListingScreen()),
                );
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Explore Menu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemsCard(List<CartItem> cartItems) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined, color: Color(0xFFFF5722), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Order Items',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${CartManager.totalItemCount} items',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF475569)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 62,
                        height: 62,
                        child: Image.network(
                          item.food.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFFFF3E0),
                            child: const Icon(Icons.fastfood, color: Color(0xFFFF5722)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.food.name,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF0F172A)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.customizations.isNotEmpty)
                            Text(
                              item.customizations.join(', '),
                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${item.totalPrice.toInt()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFF5722),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QuantitySelector(
                      quantity: item.quantity,
                      onIncrement: () {
                        setState(() {
                          CartManager.increaseQuantity(index);
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          CartManager.decreaseQuantity(index);
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red, size: 20),
                      onPressed: () {
                        setState(() {
                          CartManager.removeFromCart(index);
                        });
                      },
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

  // Coupon & Promo Code Section
  Widget _buildCouponFormCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Form(
        key: _couponFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.local_offer_outlined, color: Color(0xFFFF5722), size: 18),
                SizedBox(width: 8),
                Text(
                  'Apply Coupons & Offers',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _couponController,
                    textCapitalization: TextCapitalization.characters,
                    style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w700, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Enter "CRAVECART50" or "WELCOME20"',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _handleApplyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                ),
              ],
            ),
            if (_couponMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _couponMessage!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: CartManager.discountAmount > 0 ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBillSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Item Subtotal', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
              Text('₹${CartManager.subtotal.toInt()}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A))),
            ],
          ),
          if (CartManager.discountAmount > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Coupon Discount (${CartManager.appliedCouponCode})', style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w600)),
                Text('-₹${CartManager.discountAmount.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.green)),
              ],
            ),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Partner Fee', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
              Text('₹${CartManager.deliveryFee.toInt()}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF0F172A))),
            ],
          ),
          const Divider(height: 22, color: Color(0xFFF1F5F9)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Grand Total', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF0F172A))),
              Text(
                '₹${CartManager.total.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFFFF5722)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Delivery Address & Details Section
  Widget _buildDeliveryFormCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on, color: Color(0xFFFF5722), size: 20),
                SizedBox(width: 8),
                Text(
                  'Delivery Address & Contact',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Name Field
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              cursorColor: const Color(0xFFFF5722),
              decoration: InputDecoration(
                labelText: 'Full Name *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                hintText: 'e.g. Sweta Kadam',
                prefixIcon: const Icon(Icons.person_outline, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Please enter your name';
                if (value.trim().length < 3) return 'Name must be at least 3 characters';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Mobile Number Field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              cursorColor: const Color(0xFFFF5722),
              decoration: InputDecoration(
                labelText: 'Mobile Phone *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                hintText: '10-digit mobile number',
                prefixIcon: const Icon(Icons.phone_outlined, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Please enter mobile number';
                if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) return 'Enter a valid 10-digit mobile number';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Delivery Address Field
            TextFormField(
              controller: _addressController,
              maxLines: 2,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              cursorColor: const Color(0xFFFF5722),
              decoration: InputDecoration(
                labelText: 'House / Street Address *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                hintText: 'e.g. Flat 402, Green Meadows, Ghodbunder Rd, Thane West',
                prefixIcon: const Icon(Icons.home_outlined, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Please enter delivery address';
                if (value.trim().length < 8) return 'Please provide full address details';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Pincode Field
            TextFormField(
              controller: _pincodeController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'City Pincode *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                hintText: 'e.g. 400607 (Thane)',
                prefixIcon: const Icon(Icons.pin_drop_outlined, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Please enter pincode';
                if (value.trim().length < 5) return 'Enter a valid pincode';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Delivery Slot Dropdown
            DropdownButtonFormField<String>(
              initialValue: _deliverySlot,
              decoration: InputDecoration(
                labelText: 'Preferred Delivery Timing',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                prefixIcon: const Icon(Icons.alarm_on_rounded, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
              ),
              items: [
                'Standard (30-40 mins)',
                'Priority Express (15-20 mins)',
                'Evening Slot (7:00 PM - 8:00 PM)',
                'Late Night Craving (10:00 PM+)',
              ].map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600, fontSize: 13)))).toList(),
              onChanged: (val) => setState(() => _deliverySlot = val!),
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeTrackColor: const Color(0xFFFF5722),
              title: const Text('Save delivery details for next order', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
              value: _saveDetails,
              onChanged: (val) => setState(() => _saveDetails = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSelectionCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.payment, color: Color(0xFFFF5722), size: 20),
              SizedBox(width: 8),
              Text(
                'Payment Mode',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          const SizedBox(height: 10),

          RadioGroup<String>(
            groupValue: _paymentMethod,
            onChanged: (val) {
              if (val != null) {
                setState(() => _paymentMethod = val);
              }
            },
            child: const Column(
              children: [
                RadioListTile<String>(
                  activeColor: Color(0xFFFF5722),
                  contentPadding: EdgeInsets.zero,
                  value: 'Cash on Delivery',
                  title: Text('Cash on Delivery (COD)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0F172A))),
                  subtitle: Text('Pay with cash upon arrival', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  secondary: Icon(Icons.money_rounded, color: Colors.green),
                ),
                Divider(height: 1, color: Color(0xFFF1F5F9)),
                RadioListTile<String>(
                  activeColor: Color(0xFFFF5722),
                  contentPadding: EdgeInsets.zero,
                  value: 'UPI (GPay / PhonePe / Paytm)',
                  title: Text('UPI (GPay / PhonePe / Paytm)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0F172A))),
                  subtitle: Text('Instant contactless payment', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  secondary: Icon(Icons.qr_code_2_rounded, color: Colors.blue),
                ),
                Divider(height: 1, color: Color(0xFFF1F5F9)),
                RadioListTile<String>(
                  activeColor: Color(0xFFFF5722),
                  contentPadding: EdgeInsets.zero,
                  value: 'Credit / Debit Card',
                  title: Text('Credit / Debit Card', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0F172A))),
                  subtitle: Text('Visa, MasterCard, RuPay', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  secondary: Icon(Icons.credit_card_rounded, color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
