import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  String _selectedCity = 'Thane, Maharashtra';
  bool _vegOnly = false;
  bool _notificationsEnabled = true;
  bool _isEditing = false;

  final List<String> _cities = [
    'Thane, Maharashtra',
    'Mumbai, Maharashtra',
    'Navi Mumbai, Maharashtra',
    'Pune, Maharashtra',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Sweta Kadam');
    _phoneController = TextEditingController(text: '9876543210');
    _emailController = TextEditingController(text: 'sweta.kadam@example.com');
    _addressController = TextEditingController(
      text: 'Flat 402, Green Meadows, Ghodbunder Road, Thane West, Maharashtra - 400607',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_profileFormKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Profile updated! Default delivery set to ${_nameController.text.trim()}, $_selectedCity',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      drawer: CustomDrawer(onRefresh: () => setState(() {})),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check_rounded : Icons.edit_note_rounded,
              color: const Color(0xFFFF5722),
              size: 26,
            ),
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar & Info Card
            _buildProfileHeaderCard(),
            const SizedBox(height: 16),

            // CraveCart Gold Membership Card
            _buildMembershipCard(),
            const SizedBox(height: 18),

            // Profile Form (Editable)
            _buildProfileFormCard(),
            const SizedBox(height: 18),

            // Saved Delivery Addresses Section
            _buildSavedAddressesCard(),
            const SizedBox(height: 18),

            // App & Dining Preferences
            _buildPreferencesCard(),
            const SizedBox(height: 18),

            // Recent Orders Quick Summary
            _buildRecentOrdersCard(),
            const SizedBox(height: 24),

            // Logout Action Button
            _buildLogoutButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Profile Header Card
  Widget _buildProfileHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5722).withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'SK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.phone_iphone_rounded, size: 14, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Text(
                      '+91 ${_phoneController.text}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFFFF5722)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _selectedCity,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF5722),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Gold Membership Card
  Widget _buildMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: Color(0xFFFFD700),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'CRAVECART GOLD',
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.verified, color: Color(0xFFFFD700), size: 14),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'Free Delivery in Thane • 580 Points',
                  style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5722),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'ACTIVE',
              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  // Profile Form Card
  Widget _buildProfileFormCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _profileFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.person_outline_rounded, color: Color(0xFFFF5722), size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isEditing)
                  TextButton.icon(
                    onPressed: () => setState(() => _isEditing = true),
                    icon: const Icon(Icons.edit, size: 14, color: Color(0xFFFF5722)),
                    label: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Color(0xFFFF5722),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),

            // Name Field
            TextFormField(
              controller: _nameController,
              enabled: _isEditing,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'Full Name *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                prefixIcon: const Icon(Icons.person, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: _isEditing ? const Color(0xFFF8FAFC) : const Color(0xFFF1F5F9),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (val) => val == null || val.trim().length < 3 ? 'Enter at least 3 characters' : null,
            ),
            const SizedBox(height: 12),

            // Phone Field
            TextFormField(
              controller: _phoneController,
              enabled: _isEditing,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'Mobile Number *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                prefixIcon: const Icon(Icons.phone, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: _isEditing ? const Color(0xFFF8FAFC) : const Color(0xFFF1F5F9),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (val) => val == null || !RegExp(r'^[0-9]{10}$').hasMatch(val.trim()) ? 'Enter a valid 10-digit number' : null,
            ),
            const SizedBox(height: 12),

            // Email Field
            TextFormField(
              controller: _emailController,
              enabled: _isEditing,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'Email Address *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                prefixIcon: const Icon(Icons.email_outlined, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: _isEditing ? const Color(0xFFF8FAFC) : const Color(0xFFF1F5F9),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (val) => val == null || !val.contains('@') ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: 12),

            // City / Region Dropdown
            DropdownButtonFormField<String>(
              initialValue: _selectedCity,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'City & State *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                prefixIcon: const Icon(Icons.location_city_rounded, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: _isEditing ? const Color(0xFFF8FAFC) : const Color(0xFFF1F5F9),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              items: _cities.map((city) {
                return DropdownMenuItem(value: city, child: Text(city, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))));
              }).toList(),
              onChanged: _isEditing ? (val) => setState(() => _selectedCity = val!) : null,
            ),
            const SizedBox(height: 12),

            // Primary Address Field
            TextFormField(
              controller: _addressController,
              enabled: _isEditing,
              maxLines: 2,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'Default Delivery Address (Thane, Maharashtra) *',
                labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                prefixIcon: const Icon(Icons.home_work_outlined, size: 20, color: Color(0xFF64748B)),
                filled: true,
                fillColor: _isEditing ? const Color(0xFFF8FAFC) : const Color(0xFFF1F5F9),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
              ),
              validator: (val) => val == null || val.trim().length < 8 ? 'Provide complete address' : null,
            ),

            if (_isEditing) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save_rounded, size: 18),
                  label: const Text('Save Profile Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Saved Addresses Card
  Widget _buildSavedAddressesCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.bookmark_border_rounded, color: Color(0xFF059669), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Saved Addresses (Thane & Mumbai)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Address 1: Home (Thane West)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.home_rounded, color: Color(0xFF059669), size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF065F46)),
                          ),
                          SizedBox(width: 6),
                          Text(
                            '• DEFAULT',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF059669)),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Flat 402, Green Meadows, Ghodbunder Rd, Thane West, Maharashtra - 400607',
                        style: TextStyle(fontSize: 12, color: Color(0xFF047857), height: 1.3),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.check_circle, color: Color(0xFF059669), size: 20),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Address 2: Work (Wagle Estate, Thane)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.work_rounded, color: Color(0xFF64748B), size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Work / Office',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF0F172A)),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Unit 501, Opus IT Park, Road No. 16, Wagle Estate, Thane West - 400604',
                        style: TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Preferences Card
  Widget _buildPreferencesCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.tune_rounded, color: Color(0xFFFF5722), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Dining & App Preferences',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Material(
            color: Colors.transparent,
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeTrackColor: const Color(0xFF059669),
              title: const Text('Pure Veg Mode', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
              subtitle: const Text('Show only vegetarian food items', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              value: _vegOnly,
              onChanged: (val) => setState(() => _vegOnly = val),
            ),
          ),
          const Divider(height: 1),
          Material(
            color: Colors.transparent,
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeTrackColor: const Color(0xFFFF5722),
              title: const Text('Live Order SMS & Notifications', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
              subtitle: const Text('Get instant delivery status updates', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              value: _notificationsEnabled,
              onChanged: (val) => setState(() => _notificationsEnabled = val),
            ),
          ),
        ],
      ),
    );
  }

  // Recent Orders Card
  Widget _buildRecentOrdersCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.history_rounded, color: Color(0xFFFF5722), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Recent Orders in Thane',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildOrderItemRow('Order #CC-84920', 'Truffle Mushroom Pizza + Burger', '₹689', 'Delivered • Thane West'),
          const Divider(height: 16),
          _buildOrderItemRow('Order #CC-72314', 'Paneer Tikka Biryani Platter', '₹349', 'Delivered • Ghodbunder Rd'),
        ],
      ),
    );
  }

  Widget _buildOrderItemRow(String orderId, String items, String price, String status) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.receipt_long_rounded, color: Color(0xFFFF5722), size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderId, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF0F172A))),
              Text(items, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(status, style: const TextStyle(fontSize: 10, color: Color(0xFF059669), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Color(0xFF0F172A))),
      ],
    );
  }

  // Logout Button
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Sign Out'),
              content: const Text('Are you sure you want to sign out of CraveCart?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signed out successfully')),
                    );
                  },
                  child: const Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 18),
        label: const Text(
          'Sign Out',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFECDD3)),
          backgroundColor: const Color(0xFFFFF1F2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
