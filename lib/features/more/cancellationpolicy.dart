import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

class CancellationPolicyScreen extends StatelessWidget {
  const CancellationPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cancellationPolicyText = '''
Effective Date: 

PG MART understands that users may need to cancel orders under certain conditions. The following cancellation terms apply:

1. Cancellations Are Allowed:
• Within 30 minutes of placing a same-day order
• At least 2 hours before the scheduled delivery time

2. Cancellations Are Not Allowed:
• Once the order is marked “Ready for Dispatch”
• When the order is within 1 hour of scheduled delivery time
• For custom or final sale items

3. Cancellation Process:
• Users can cancel directly in the app before the cut-off time
• If the cancellation window has passed, please contact support to explain the issue
• PG MART reserves the right to deny late cancellations if the vendor has already begun processing
''';

    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('cancellation_policy', context)}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            cancellationPolicyText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
