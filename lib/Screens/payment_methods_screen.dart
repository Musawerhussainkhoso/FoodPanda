import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment methods'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined,
                  color: AppTheme.primaryColor),
              title: const Text('Cash on delivery'),
              subtitle: const Text('Pay with cash when your order arrives'),
              trailing: Chip(
                label: const Text('Default'),
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                backgroundColor: AppTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading:
                  Icon(Icons.credit_card, color: AppTheme.primaryColor),
              title: const Text('Add debit / credit card'),
              trailing: const Icon(Icons.chevron_right),
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

