import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

class RefundPolicyScreen extends StatelessWidget {
  const RefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final refundPolicyText = '''
Effective Date: 

PG MART is committed to ensuring a smooth and satisfying shopping experience. Refunds are processed for eligible issues under the following terms:

1. Refunds Are Applicable For:
• Items that are missing from the order
• Items that are expired, spoiled, or damaged upon delivery
• Incorrect items that do not match the order
• Orders that were undelivered or failed (confirmed by PG MART or the vendor)

2. Refunds Are Not Applicable For:
• Perishable or frozen items where the customer was unavailable at delivery
• Minor variations in product packaging
• Claims submitted more than 24 hours after delivery (for food items)
• Products that have been used, opened, or tampered with

3. Refund Process:
• Submit a support ticket within 24 hours of receiving your order
• Provide Order ID, a brief description, and photo evidence (if applicable)
• The PG MART team will review and respond within 24 hours

4. Refund Timeline:
• Approved refunds will be processed within 3–5 business days
• Refunds will be issued via the original payment method or PG MART wallet credit, depending on the situation
''';

    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('refund_policy', context)}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            refundPolicyText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
