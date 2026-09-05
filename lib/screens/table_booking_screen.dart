import 'package:flutter/material.dart';

class TableBookingScreen extends StatefulWidget {
  const TableBookingScreen({super.key});

  @override
  State<TableBookingScreen> createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _guests = '2 Guests';
  String _timeSlot = 'Dinner • 7:30 PM';
  String _seatingArea = 'Rooftop Garden';
  String _occasion = 'Casual Dine-in';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateController.text = '${now.day}/${now.month}/${now.year}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF059669),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _handleBooking() {
    if (_formKey.currentState!.validate()) {
      final reservationId = 'RES-${1000 + DateTime.now().millisecond}';
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.stars_rounded, color: Color(0xFF059669), size: 28),
              SizedBox(width: 8),
              Text('Table Confirmed!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reservation: $reservationId', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF059669))),
              const SizedBox(height: 8),
              Text('Guest: ${_nameController.text.trim()}'),
              Text('Party Size: $_guests'),
              Text('Date & Time: ${_dateController.text} at $_timeSlot'),
              Text('Seating: $_seatingArea'),
              Text('Occasion: $_occasion'),
              const Divider(height: 20),
              const Text('We look forward to serving you an exceptional culinary experience!', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Great, Done!'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Book a Table',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF0F172A)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF059669), Color(0xFF10B981)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF059669).withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FINE DINE EXPERIENCE', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                          SizedBox(height: 4),
                          Text('Reserve Your Table', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                          SizedBox(height: 4),
                          Text('Guaranteed seating with priority service', style: TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
                      ),
                      child: const Icon(
                        Icons.table_restaurant_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Form inputs container
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Guest Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    const SizedBox(height: 14),

                    // Name
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Primary Guest Name *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        hintText: 'e.g. Sweta Kadam',
                        prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF059669), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF059669), width: 2)),
                      ),
                      validator: (v) => (v == null || v.trim().length < 3) ? 'Please enter guest name (min 3 chars)' : null,
                    ),
                    const SizedBox(height: 14),

                    // Phone
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Contact Phone Number *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        hintText: '10-digit mobile number',
                        prefixIcon: const Icon(Icons.phone_outlined, color: Color(0xFF059669), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF059669), width: 2)),
                      ),
                      validator: (v) => (v == null || !RegExp(r'^[0-9]{10}$').hasMatch(v.trim())) ? 'Enter a valid 10-digit phone number' : null,
                    ),
                    const SizedBox(height: 14),

                    // Guests Dropdown
                    DropdownButtonFormField<String>(
                      initialValue: _guests,
                      decoration: InputDecoration(
                        labelText: 'Number of Guests *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        prefixIcon: const Icon(Icons.people_alt_outlined, color: Color(0xFF059669), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      ),
                      items: ['1 Guest', '2 Guests', '4 Guests', '6 Guests', '8+ Family / Party']
                          .map((g) => DropdownMenuItem(value: g, child: Text(g, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600))))
                          .toList(),
                      onChanged: (val) => setState(() => _guests = val!),
                    ),
                    const SizedBox(height: 14),

                    // Date Picker
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: _selectDate,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Reservation Date *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color(0xFF059669), size: 20),
                        suffixIcon: const Icon(Icons.edit_calendar_rounded, size: 18, color: Color(0xFF059669)),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Time Slot Dropdown
                    DropdownButtonFormField<String>(
                      initialValue: _timeSlot,
                      decoration: InputDecoration(
                        labelText: 'Preferred Time Slot *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        prefixIcon: const Icon(Icons.access_time_rounded, color: Color(0xFF059669), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      ),
                      items: [
                        'Lunch • 12:30 PM',
                        'Lunch • 2:00 PM',
                        'High Tea • 5:00 PM',
                        'Dinner • 7:30 PM',
                        'Dinner • 9:30 PM',
                      ].map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600))))
                          .toList(),
                      onChanged: (val) => setState(() => _timeSlot = val!),
                    ),
                    const SizedBox(height: 14),

                    // Occasion
                    DropdownButtonFormField<String>(
                      initialValue: _occasion,
                      decoration: InputDecoration(
                        labelText: 'Special Occasion',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        prefixIcon: const Icon(Icons.celebration_outlined, color: Color(0xFF059669), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      ),
                      items: ['Casual Dine-in', 'Birthday Celebration', 'Anniversary', 'Business Dinner', 'Family Gathering']
                          .map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600))))
                          .toList(),
                      onChanged: (val) => setState(() => _occasion = val!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Seating Preference Radios
              Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Seating Preference', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                      const SizedBox(height: 10),
                    RadioGroup<String>(
                      groupValue: _seatingArea,
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => _seatingArea = v);
                        }
                      },
                      child: const Column(
                        children: [
                          RadioListTile<String>(
                            activeColor: Color(0xFF059669),
                            contentPadding: EdgeInsets.zero,
                            value: 'Rooftop Garden',
                            title: Text('Rooftop Garden', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0F172A))),
                            subtitle: Text('Panoramic skyline views & open air', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                            secondary: Icon(Icons.deck_rounded, color: Color(0xFF059669)),
                          ),
                          Divider(height: 1),
                          RadioListTile<String>(
                            activeColor: Color(0xFF059669),
                            contentPadding: EdgeInsets.zero,
                            value: 'Indoor AC Bistro',
                            title: Text('Indoor AC Bistro', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0F172A))),
                            subtitle: Text('Cozy ambient lighting & soft jazz music', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                            secondary: Icon(Icons.ac_unit_rounded, color: Colors.blue),
                          ),
                          Divider(height: 1),
                          RadioListTile<String>(
                            activeColor: Color(0xFF059669),
                            contentPadding: EdgeInsets.zero,
                            value: 'Private Chef Booth',
                            title: Text('Private Chef Booth', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0F172A))),
                            subtitle: Text('Dedicated server with customized menu', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                            secondary: Icon(Icons.military_tech_rounded, color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _handleBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                  ),
                  child: const Text('Confirm Table Reservation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
