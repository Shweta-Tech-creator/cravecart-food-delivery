import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  final String? initialOrderId;

  const FeedbackScreen({super.key, this.initialOrderId});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _orderIdController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  int _starRating = 5;
  double _speedRating = 9.0;
  bool _wouldRecommend = true;

  final List<String> _ratingLabels = [
    'Needs Improvement (1/5)',
    'Fair Experience (2/5)',
    'Good & Tasty (3/5)',
    'Very Delicious (4/5)',
    'Exceptional Quality (5/5)',
  ];

  @override
  void initState() {
    super.initState();
    _orderIdController = TextEditingController(text: widget.initialOrderId ?? '#CC-84920');
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    _nameController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.thumb_up_alt_rounded, color: Color(0xFFFF5722), size: 24),
              SizedBox(width: 8),
              Text('Thank You!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thank you ${_nameController.text.trim()} for your valuable feedback!'),
              const SizedBox(height: 8),
              Text('Rating Given: $_starRating / 5 Stars (${_ratingLabels[_starRating - 1]})'),
              Text('Delivery Rating: ${_speedRating.toInt()} / 10'),
              const SizedBox(height: 10),
              const Text('Your review helps our chefs and delivery partners continuously improve!', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Close'),
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
          'Feedback & Review',
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
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5722).withValues(alpha: 0.3),
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
                          Text('WE VALUE YOUR OPINION', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
                          SizedBox(height: 4),
                          Text('Rate Your Order', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                          SizedBox(height: 4),
                          Text('Help us make your next meal even better', style: TextStyle(color: Colors.white70, fontSize: 11)),
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
                        Icons.stars_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Interactive Star Rating Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    const Text('Overall Food Experience', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        return IconButton(
                          iconSize: 36,
                          icon: Icon(
                            starIndex <= _starRating ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _starRating = starIndex;
                            });
                          },
                        );
                      }),
                    ),
                    Text(
                      _ratingLabels[_starRating - 1],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFFFF5722)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Review Input Form Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Review Details', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    const SizedBox(height: 14),

                    // Order ID
                    TextFormField(
                      controller: _orderIdController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Order ID *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        prefixIcon: const Icon(Icons.receipt_outlined, color: Color(0xFFFF5722), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter order ID' : null,
                    ),
                    const SizedBox(height: 14),

                    // Customer Name
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Your Name *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        hintText: 'e.g. Sweta Kadam',
                        prefixIcon: const Icon(Icons.person_outline, color: Color(0xFFFF5722), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
                      ),
                      validator: (v) => (v == null || v.trim().length < 3) ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 14),

                    // Comments
                    TextFormField(
                      controller: _commentsController,
                      maxLines: 3,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Comments & Suggestions *',
                        labelStyle: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 13),
                        hintText: 'How was the food quality, taste, temperature, and packaging?',
                        prefixIcon: const Icon(Icons.rate_review_outlined, color: Color(0xFFFF5722), size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFF5722), width: 2)),
                      ),
                      validator: (v) => (v == null || v.trim().length < 5) ? 'Please write a short review (min 5 chars)' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Delivery Speed Slider Card
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
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Speed Rating', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('${_speedRating.toInt()} / 10', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFFFF5722))),
                      ],
                    ),
                    Slider(
                      value: _speedRating,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      activeColor: const Color(0xFFFF5722),
                      label: '${_speedRating.toInt()}',
                      onChanged: (val) {
                        setState(() {
                          _speedRating = val;
                        });
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Slow (1)', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                        Text('Super Fast (10)', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                      ],
                    ),
                    const Divider(height: 24),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeTrackColor: const Color(0xFFFF5722),
                      title: const Text('Would you recommend CraveCart to friends?', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                      subtitle: const Text('Help us grow our foodie community', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      value: _wouldRecommend,
                      onChanged: (val) {
                        setState(() {
                          _wouldRecommend = val;
                        });
                      },
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
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                  ),
                  child: const Text('Submit Review', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
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
