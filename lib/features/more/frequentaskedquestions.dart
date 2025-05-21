import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

class FaqQuesScreen extends StatelessWidget {
  const FaqQuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqText = '''
1. What is PG MART?

PG MART is a multicultural marketplace app where you can order authentic African, Asian, Caribbean, and global products from trusted vendors and get them delivered to your doorstep across the UAE.

⸻

2. How do I place an order?
• Download the PG MART app
• Select your preferred store or vendor
• Add items to your cart
• Choose your delivery slot
• Pay via card, cash on delivery, or Tabby (Buy Now, Pay Later)

⸻

3. What payment methods are available?

We accept:
• Debit/Credit Cards
• Cash on Delivery (COD)
• Tabby (Pay in 4 monthly installments)

⸻

4. Can I cancel or edit my order?
• You can cancel within 30 minutes of placing a same-day order
• Edits are allowed up to 30 minutes before dispatch
• Once your order is marked “Ready for Dispatch”, cancellations are no longer possible

⸻

5. What is your refund policy?

We offer refunds for:
• Expired or damaged items
• Missing or wrong products
• Undelivered orders
Refund requests must be submitted within 24 hours of delivery. Refunds are processed within 3–5 business days.

⸻

6. Can I return my order?

Returns are only accepted for non-perishable, unopened items within 24 hours of delivery.
We do not accept returns for perishable or frozen products.

⸻

7. How do I contact customer support?
• Use the Support Ticket system in the app
• Or tap “Contact Us” to reach us via WhatsApp, email, or call
We respond within 24–48 hours.

⸻

8. How does Tabby work?

Tabby lets you split your payment into 4 interest-free monthly installments.
You must be approved by Tabby at checkout. PG MART is not responsible for Tabby’s approval or billing process.

⸻

9. Why is my order late or missing items?

Sometimes delivery delays or stock issues may occur.
Please check your app notifications or reach out via Support Ticket with your Order ID so we can assist you immediately.

⸻

10. Do you deliver across the UAE?

Yes, we deliver across major areas in the UAE.
Delivery slots, timing, and availability may vary depending on your location and the vendor.
''';

    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('faq', context)}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            faqText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
