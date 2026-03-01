import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class DeliveryAddressesScreen extends StatelessWidget {
  const DeliveryAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      'Home • 123 Street',
      'Office • Downtown Plaza',
      'Hostel • Block A, Room 12',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Delivery addresses'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new address (coming soon)')),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        label: const Text('Add new'),
        icon: const Icon(Icons.add_location_alt_outlined),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final address = addresses[index];
          return Card(
            child: ListTile(
              leading: Icon(
                index == 0 ? Icons.home : Icons.location_on_outlined,
                color: AppTheme.primaryColor,
              ),
              title: Text(address),
              subtitle: const Text('Tap to use this address'),
              trailing: const Icon(Icons.chevron_right),
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

