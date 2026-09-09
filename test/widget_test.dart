import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crave_cart/main.dart';
import 'package:crave_cart/screens/table_booking_screen.dart';
import 'package:crave_cart/screens/feedback_screen.dart';
import 'package:crave_cart/screens/profile_screen.dart';

void main() {
  testWidgets('App loads and displays home dashboard with Thane address and Profile nav', (WidgetTester tester) async {
    await tester.pumpWidget(const CraveCartApp());
    expect(find.textContaining('Crave'), findsWidgets);
    expect(find.text('Home • Thane, Maharashtra'), findsOneWidget);
    expect(find.text('Explore Categories'), findsOneWidget);
    expect(find.text('Book Table'), findsOneWidget);
    expect(find.text('Feedback'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('Table Booking Screen renders with inputs and validation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TableBookingScreen()));
    expect(find.text('Reserve Your Table'), findsOneWidget);
    final buttonFinder = find.text('Confirm Table Reservation');
    expect(buttonFinder, findsOneWidget);
    
    // Ensure button is visible before tapping
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    expect(find.text('Please enter guest name (min 3 chars)'), findsOneWidget);
  });

  testWidgets('Feedback Screen renders with stars and review inputs', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FeedbackScreen()));
    expect(find.text('Rate Your Order'), findsOneWidget);
    expect(find.text('Overall Food Experience'), findsOneWidget);
    final submitFinder = find.text('Submit Review');
    expect(submitFinder, findsOneWidget);

    // Ensure submit button is visible before tapping
    await tester.ensureVisible(submitFinder);
    await tester.tap(submitFinder);
    await tester.pumpAndSettle();
    expect(find.text('Please enter your name'), findsOneWidget);
  });

  testWidgets('Profile Screen renders user info, Thane addresses, and form validation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
    expect(find.text('Sweta Kadam'), findsWidgets);
    expect(find.text('Thane, Maharashtra'), findsWidgets);
    expect(find.text('CRAVECART GOLD'), findsOneWidget);
    expect(find.text('Saved Addresses (Thane & Mumbai)'), findsOneWidget);
    expect(find.text('Flat 402, Green Meadows, Ghodbunder Rd, Thane West, Maharashtra - 400607'), findsOneWidget);

    expect(find.text('Personal Details'), findsOneWidget);
  });
}

