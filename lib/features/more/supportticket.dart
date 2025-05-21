import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});

  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _orderIdController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _issueCategory;
  String? _preferredContact;
  XFile? _image;
  String? _ticketId;

  final List<String> _issueCategories = [
    'Order not delivered',
    'Wrong item received',
    'Damaged/expired item',
    'Refund not received',
    'Payment issue',
    'App error',
    'Other'
  ];

  final List<String> _contactMethods = [
    'WhatsApp',
    'Phone call',
    'Email'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
  }

  void _submitTicket() {
    if (_formKey.currentState!.validate()) {
      final id = '#PG${Random().nextInt(999999).toString().padLeft(6, '0')}';
      setState(() {
        _ticketId = id;
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Ticket Submitted'),
          content: Text(
              'Thank you, your support ticket has been received.\n\nOur team will respond within 24–48 hours.\n\nYour Ticket ID is: $id'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit a Complaint or Issue')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('1. Full Name'),
                TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),

                const Text('2. Phone Number or Email Address'),
                TextFormField(
                  controller: _contactController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter contact info' : null,
                ),
                const SizedBox(height: 16),

                const Text('3. Order ID (if related to an order)'),
                TextFormField(
                  controller: _orderIdController,
                  decoration: const InputDecoration(hintText: 'Example: #PG123456'),
                ),
                const SizedBox(height: 16),

                const Text('4. Issue Category'),
                DropdownButtonFormField<String>(
                  value: _issueCategory,
                  items: _issueCategories
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _issueCategory = val),
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 16),

                const Text('5. Brief Description of the Issue'),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  validator: (value) =>
                      value!.isEmpty ? 'Please describe the issue' : null,
                ),
                const SizedBox(height: 16),

                const Text('6. Upload Image or Screenshot (optional)'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Upload'),
                    ),
                    if (_image != null) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle, color: Colors.green),
                      const Text(' Uploaded'),
                    ]
                  ],
                ),
                const SizedBox(height: 16),

                const Text('7. Preferred Contact Method'),
                DropdownButtonFormField<String>(
                  value: _preferredContact,
                  items: _contactMethods
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _preferredContact = val),
                  validator: (value) =>
                      value == null ? 'Please select a method' : null,
                ),
                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: _submitTicket,
                    child: const Text('Submit Ticket'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
