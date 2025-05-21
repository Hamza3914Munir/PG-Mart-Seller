import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final termsText = '''
Effective Date:
By using the PG MART mobile app or website (“the Platform”), you agree to abide by the following terms and conditions.

1. Introduction
PG MART is a multicultural online marketplace that connects users to trusted vendors offering authentic African, Asian, Caribbean, and international products across the UAE.

2. Account Registration
• Users must be at least 18 years old to register or place orders.
• You are responsible for the confidentiality of your login credentials.
• PG MART may suspend or delete accounts that violate these terms.

3. Product Listings & Pricing
• All products are listed by independent vendors.
• Prices may change without prior notice and may vary by vendor.
• Images shown are for reference only; actual products may differ slightly due to packaging updates or brand changes.

4. Orders & Payments
• Orders can be paid via card, cash on delivery, or Tabby (Buy Now, Pay Later).
• Orders are not confirmed until payment is successful or accepted by the vendor.
• PG MART may cancel or adjust orders based on availability or vendor errors.

5. Delivery & Pickup
• Delivery timelines depend on vendor readiness and your selected delivery slot.
• Same-day and scheduled deliveries are offered based on item type and availability.
• Users are responsible for being available to receive the order during the selected time window.

6. Refunds, Returns & Cancellations
• Refunds will be processed for:
  • Incorrect or missing items
  • Expired or damaged goods
  • Failed or undelivered orders
• Refunds take 3–5 business days after approval.
• Returns are accepted only for non-perishable items in their original sealed condition within 48 hours of delivery.
• Cancellations must be made within:
  • 30 minutes of placing a same-day delivery order
  • 2 hours before scheduled delivery for future orders

7. User Conduct
• Users must behave respectfully toward vendors, riders, and customer support agents.
• Harassment, false claims, or any form of abuse may lead to account suspension.
• All communication must be conducted through official PG MART channels.

8. Support & Complaint Handling
• For any order issues, users must use the in-app Support Ticket system.
• You will be required to provide your name, order ID, issue description, and optionally upload proof.
• Support responds within 24–48 business hours.

9. Liability
• PG MART is not liable for issues caused by vendor errors, third-party delivery delays, or product quality.
• PG MART’s liability is limited to the value of the affected transaction.

10. Privacy
• PG MART collects basic personal and order-related data to fulfill and improve services.
• Your information will not be sold to third parties.
• Data shared with vendors or delivery partners is limited to fulfillment needs only. For more, please read our [Privacy Policy].

11. Governing Law
These terms are governed by the laws of the United Arab Emirates. Disputes will be handled through UAE courts.

12. Changes to Terms
PG MART may modify these Terms & Conditions at any time. Continued use of the app constitutes acceptance of any updated terms.

13. Required Information for Account Use
To place orders on PG MART, users must provide:
• Full name and phone number
• Accurate delivery address
• Valid payment method (for card or Tabby)

14. User Ratings & Reviews
Users may leave honest ratings and reviews. PG MART reserves the right to remove any review that contains:
• Hate speech or threats
• Defamation or false claims
• Personal attacks
• Off-platform promotions or spam

15. Promotions & Coupons
Discount codes or referral bonuses may be offered occasionally. These are subject to:
• Expiry without notice
• One-time use per user
• Disqualification for misuse or abuse
PG MART reserves the right to cancel promotions if fraud is suspected.

16. Account Suspension or Termination
PG MART may suspend or terminate user accounts without prior notice for:
• Repeated refund abuse
• Fraudulent activity
• Harassment or platform misuse
• Violation of PG MART policies

17. Use of Third-Party Services
To operate efficiently, PG MART integrates with trusted third-party services including:
• Payment gateways (e.g. Tabby)
• Logistics and delivery partners
• Fraud and risk protection software
By using PG MART, you agree that limited personal data may be securely shared with these services for order fulfillment.

18. Tabby Payments (Buy Now, Pay Later)
Tabby is a third-party financial partner. By selecting Tabby at checkout, you agree to Tabby’s separate terms, approval process, and repayment rules. PG MART is not liable for Tabby’s financing decisions or repayment-related concerns.

By signing up, you accept PG MART’s Terms & Privacy Policy.
    ''';

    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('terms_condition', context)}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            termsText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
