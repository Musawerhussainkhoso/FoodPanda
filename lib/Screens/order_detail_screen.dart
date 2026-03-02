import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

Widget _buildBreadcrumb(BuildContext context, String orderId) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'My Orders',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            Icons.chevron_right,
            size: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          orderId,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order $orderId',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumb(context, orderId),
            const Divider(),
            const SizedBox(height: 8),
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

