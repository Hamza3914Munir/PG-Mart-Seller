import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacyPolicyText = '''
Effective Date: 
This Privacy Policy explains how PG MART (“we”, “our”, “us”) collects, uses, stores, and protects your information when you use our mobile app or website (the “Platform”).

1. Information We Collect
We may collect the following types of personal data from you:
• Personal Identification Info
Name, email, phone number, delivery address
• Order & Transaction Details
Order history, payment method (no card details are stored), delivery notes
• Device Information
Device type, IP address, app version, and basic technical logs
• Location Data
For delivery services or store suggestions (only if permission is granted)
• Support Communication
Messages, complaints, or images submitted via support ticket or app chat

2. How We Use Your Information
We use your information to:
• Create and manage your account
• Process and deliver your orders
• Handle payments and refunds
• Provide customer service
• Improve app functionality and user experience
• Send order updates, promos, and important notices

3. Sharing Your Information
We do not sell your personal information.
We may securely share your data with:
• Vendors (to fulfill your order)
• Delivery partners (to deliver your goods)
• Payment gateways (for secure transactions)
• Tabby (if you choose Buy Now, Pay Later)
These partners are required to keep your information safe and only use it for service-related purposes.

4. Use of Tabby (Buy Now, Pay Later)
If you select Tabby at checkout, your information will be securely shared with Tabby for financing approval.
PG MART does not control Tabby’s decision-making and is not liable for their data use.
We encourage you to review Tabby’s privacy policy before using their services.

5. Communication & Notifications
We may send you order updates, reminders, and promotions via:
• App notifications
• WhatsApp or SMS
• Email (if provided)
You can control some of these in your app settings or opt-out where available.

6. Data Retention
We keep your information only as long as necessary to:
• Maintain your account
• Complete any active orders or refunds
• Comply with legal and financial obligations
When no longer needed, your data is deleted or anonymized.

7. Data Security
We take reasonable steps to protect your data using:
• Secure servers
• Encrypted connections (SSL)
• Internal access controls
However, no system is 100% secure, and by using the platform, you acknowledge that PG MART cannot guarantee absolute data protection.

8. Your Rights
Depending on local laws, you may have the right to:
• Access or update your personal data
• Request data deletion (where allowed)
• Withdraw consent to marketing messages
• Object to or restrict certain data uses
To request any of these, contact:
Email: support@pgmart.com

9. Children’s Privacy
PG MART does not knowingly collect personal information from children under 18 years.
If we learn that a child has submitted information, we will delete it promptly.

10. Third-Party Links
The app may link to third-party services (like Tabby, delivery tracking tools).
We are not responsible for their privacy practices.
Please review their policies before using those services.

11. Updates to This Policy
This Privacy Policy may be updated at any time.
Changes will be posted in the app and reflected by the updated “Effective Date” at the top.

12. Contact Us
If you have questions about this policy or how we use your data, contact:
Email: support@pgmart.com
Phone: +971524068083
''';

    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('privacy_policy', context)}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            privacyPolicyText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
