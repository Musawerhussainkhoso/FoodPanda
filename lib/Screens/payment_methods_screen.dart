import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:foodpanda_app/widgets/food_express_app_bar.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const FoodExpressAppBar(title: 'Payment methods'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.12),
                child: Icon(
                  Icons.payments_outlined,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: const Text(
                'Cash on delivery',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Pay with cash when your order arrives'),
              trailing: Chip(
                label: const Text('Default'),
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.12),
                child: Icon(
                  Icons.credit_card_rounded,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: const Text(
                'Add debit / credit card',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Card adding flow coming soon'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
