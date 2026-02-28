import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text('Order $orderId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Delivered • 20-30 min'),
            const SizedBox(height: 16),
            const Text(
              'Items',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('McChicken Meal'),
              subtitle: Text('1 x Rs. 750'),
              trailing: Text('Rs. 750'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Fries & Drink'),
              subtitle: Text('1 x Rs. 250'),
              trailing: Text('Rs. 250'),
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                'Rs. 1,250',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

