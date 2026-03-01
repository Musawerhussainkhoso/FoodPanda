import 'package:flutter/material.dart';
import 'package:foodpanda_app/Providers/cart_provider.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedAddress = 'Home • 123 Street';
  String _selectedPayment = 'Cash on delivery';
  static const double _deliveryFee = 2.99;

  void _showAddressSelector() {
    final addresses = [
      'Home • 123 Street',
      'Office • Downtown Plaza',
      'Hostel • Block A, Room 12',
    ];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select delivery address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...addresses.map(
              (address) => ListTile(
                leading: Icon(
                  address.startsWith('Home') ? Icons.home : Icons.location_on_outlined,
                  color: AppTheme.primaryColor,
                ),
                title: Text(address),
                trailing: _selectedAddress == address
                    ? Icon(Icons.check_circle, color: AppTheme.primaryColor)
                    : null,
                onTap: () {
                  setState(() => _selectedAddress = address);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showPaymentSelector() {
    final payments = [
      ('Cash on delivery', 'Pay with cash when your order arrives', Icons.account_balance_wallet_outlined),
      ('Card', 'Pay with debit/credit card', Icons.credit_card),
    ];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select payment method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...payments.map(
              (p) => ListTile(
                leading: Icon(p.$3, color: AppTheme.primaryColor),
                title: Text(p.$1),
                subtitle: Text(p.$2, style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: _selectedPayment == p.$1
                    ? Icon(Icons.check_circle, color: AppTheme.primaryColor)
                    : null,
                onTap: () {
                  setState(() => _selectedPayment = p.$1);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage(String imagePath) {
    final isAsset = imagePath.startsWith('assets/');
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: isAsset
          ? Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => _buildPlaceholder(),
            )
          : Image.network(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey[200],
      child: Icon(Icons.fastfood, color: Colors.grey),
    );
  }

  void _placeOrder() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    if (cart.items.isEmpty) return;

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            SizedBox(height: 16),
            Text(
              'Order Placed Successfully!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Your order will be delivered to $_selectedAddress',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cart.clear();
                  navigator.pop(); // Close dialog
                  navigator.popUntil((route) => route.isFirst); // Back to Home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final subtotal = cart.totalAmount;
    final total = subtotal + _deliveryFee;

    if (cart.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Checkout', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
              SizedBox(height: 16),
              Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
              SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Go back to cart'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Text('Delivery Address', style: AppTheme.headline1.copyWith(fontSize: 18)),
            SizedBox(height: 8),
            InkWell(
              onTap: _showAddressSelector,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.primaryColor, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_selectedAddress, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                          Text('Tap to change address', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Order Summary
            Text('Order Summary', style: AppTheme.headline1.copyWith(fontSize: 18)),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => Divider(height: 1),
                itemBuilder: (ctx, i) {
                  final item = cart.items.values.toList()[i];
                  return Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        _buildItemImage(item.imagePath),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: TextStyle(fontWeight: FontWeight.w600)),
                              Text('Qty: ${item.quantity} × \$${item.price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                        Text(
                          '\$${item.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),

            // Payment Method
            Text('Payment Method', style: AppTheme.headline1.copyWith(fontSize: 18)),
            SizedBox(height: 8),
            InkWell(
              onTap: _showPaymentSelector,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment, color: AppTheme.primaryColor, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(_selectedPayment, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Price Breakdown
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  _buildPriceRow('Subtotal', subtotal),
                  SizedBox(height: 8),
                  _buildPriceRow('Delivery fee', _deliveryFee),
                  Divider(height: 24),
                  _buildPriceRow('Total', total, isTotal: true),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Place Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primaryColor : Colors.black87,
          ),
        ),
      ],
    );
  }
}
