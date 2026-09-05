import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import 'feedback_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String phoneNumber;
  final String deliveryAddress;
  final String paymentMethod;
  final double totalAmount;
  final List<CartItem> orderedItems;

  const OrderConfirmationScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.phoneNumber,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.totalAmount,
    required this.orderedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          'Order Confirmed',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF0F172A)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Animated Success Checkmark
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 650),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF22C55E), width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF16A34A),
                      size: 48,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),

            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const Text(
              'Your chef is preparing your meal with love & hygiene.',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),

            // Live Order Tracker Card
            Container(
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
                    'Order Status Tracker',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 14),
                  _buildTrackerStep(
                    icon: Icons.check_circle,
                    title: 'Order Confirmed',
                    subtitle: 'Restaurant has accepted your order',
                    isDone: true,
                  ),
                  _buildTrackerStep(
                    icon: Icons.outdoor_grill,
                    title: 'Kitchen is Preparing',
                    subtitle: 'Estimated time: 15-20 mins',
                    isDone: true,
                  ),
                  _buildTrackerStep(
                    icon: Icons.delivery_dining,
                    title: 'Rider on the Way',
                    subtitle: 'Contactless delivery assigned',
                    isDone: false,
                  ),
                  _buildTrackerStep(
                    icon: Icons.home_rounded,
                    title: 'Delivered to Doorstep',
                    subtitle: 'Estimated arrival in 30 mins',
                    isDone: false,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Order Receipt Card
            Container(
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
                children: [
                  _buildDetailRow(title: 'Order ID', value: orderId, valueColor: const Color(0xFFFF5722), isBold: true),
                  const Divider(height: 18, color: Color(0xFFF1F5F9)),
                  _buildDetailRow(title: 'Customer Name', value: customerName),
                  const Divider(height: 18, color: Color(0xFFF1F5F9)),
                  _buildDetailRow(title: 'Phone', value: phoneNumber),
                  const Divider(height: 18, color: Color(0xFFF1F5F9)),
                  _buildDetailRow(title: 'Delivery Address', value: deliveryAddress),
                  const Divider(height: 18, color: Color(0xFFF1F5F9)),
                  _buildDetailRow(title: 'Payment Mode', value: paymentMethod),
                  const Divider(height: 18, color: Color(0xFFF1F5F9)),
                  _buildDetailRow(
                    title: 'Total Paid',
                    value: '₹${totalAmount.toInt()}',
                    valueColor: const Color(0xFFFF5722),
                    isBold: true,
                    valueSize: 17,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Rate Order Action
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackScreen(initialOrderId: orderId),
                    ),
                  );
                },
                icon: const Icon(Icons.star_rounded, color: Color(0xFFFF5722)),
                label: const Text(
                  'Rate & Review This Order',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFFFF5722)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF5722), width: 1.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: const Color(0xFFFFF3E0),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Back to Home Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackerStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDone,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFFFF5722) : const Color(0xFFE2E8F0),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 14),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 24,
                color: isDone ? const Color(0xFFFF5722) : const Color(0xFFE2E8F0),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isDone ? FontWeight.w800 : FontWeight.w600,
                color: isDone ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 11, color: isDone ? const Color(0xFF64748B) : const Color(0xFFCBD5E1)),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required String title,
    required String value,
    Color? valueColor,
    bool isBold = false,
    double valueSize = 13,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: valueColor ?? const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }
}
