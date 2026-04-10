import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:foodpanda_app/widgets/food_express_app_bar.dart';

class DeliveryAddressesScreen extends StatelessWidget {
  const DeliveryAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      'Personal · 123 Street',
      'Office · Downtown Plaza',
      'Hostel · Block A, Room 12',
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const FoodExpressAppBar(title: 'Delivery addresses'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new address (coming soon)')),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        label: const Text('Add new'),
        icon: const Icon(Icons.add_location_alt_outlined),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final address = addresses[index];
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            elevation: 0,
            shadowColor: Colors.black12,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.12),
                child: Icon(
                  index == 0
                      ? Icons.home_work_outlined
                      : Icons.location_on_outlined,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: Text(
                address,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Tap to use this address'),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Using: $address')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
