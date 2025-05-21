import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

class ReturnPolicyScreen extends StatelessWidget {
  const ReturnPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final returnPolicyText = '''
Effective Date: 

PG MART only accepts returns for eligible items under the following terms:

1. Eligible Items for Return:
• Non-perishable items such as packaged goods, beauty products, household items
• Items must be unopened, unused, and in original packaging
• Return request must be made within 48 hours of delivery

2. Non-Returnable Items:
• Perishable food items (e.g., vegetables, frozen meats, palm oil, etc.)
• Any product that has been opened, used, or tampered with
• Custom-prepared orders or items marked as “Final Sale”

3. Return Process:
• Contact support within 24 hours with the Order ID and reason
• If approved, a pickup will be scheduled (if applicable) or vendor will arrange return
• Item must be returned in resellable condition
''';

    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('return_policy', context)}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            returnPolicyText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
