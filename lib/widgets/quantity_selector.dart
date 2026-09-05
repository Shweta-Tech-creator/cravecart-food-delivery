import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double iconSize;
  final double padding;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.iconSize = 18,
    this.padding = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement button
          InkWell(
            onTap: onDecrement,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Icon(
                Icons.remove,
                size: iconSize,
                color: quantity > 1 ? const Color(0xFF2D3142) : Colors.grey,
              ),
            ),
          ),
          // Animated quantity number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$quantity',
                key: ValueKey<int>(quantity),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
            ),
          ),
          // Increment button
          InkWell(
            onTap: onIncrement,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Icon(
                Icons.add,
                size: iconSize,
                color: const Color(0xFFFF5722),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
