import 'package:flutter/material.dart';
import 'package:foodpanda_app/Providers/cart_provider.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

Widget _buildBreadcrumb(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
    child: Row(
      children: const [
        Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            Icons.chevron_right,
            size: 16,
            color: Colors.white70,
          ),
        ),
        Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    
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
        titleSpacing: 0,
        title: _buildBreadcrumb(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
                        SizedBox(height: 20),
                        Text('Your cart is empty', style: AppTheme.headline1.copyWith(fontSize: 20, color: Colors.grey[400])),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final item = cart.items.values.toList()[i];
                      final productId = cart.items.keys.toList()[i];
                      
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: item.imagePath.startsWith('assets/')
                                  ? Image.asset(
                                      item.imagePath,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.fastfood, color: Colors.grey),
                                      ),
                                    )
                                  : Image.network(
                                      item.imagePath,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.fastfood, color: Colors.grey),
                                      ),
                                    ),
                            ),
                            title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline, color: AppTheme.primaryColor),
                                  onPressed: () {
                                    cart.removeSingleItem(productId);
                                  },
                                ),
                                Text('${item.quantity}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline, color: AppTheme.primaryColor),
                                  onPressed: () {
                                    cart.addItem(productId, item.price, item.name, item.imagePath, item.restaurantId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
             padding: EdgeInsets.all(20),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
               boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
             ),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                     Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                   ],
                 ),
                 SizedBox(height: 20),
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                     onPressed: cart.totalAmount <= 0 ? null : () {
                       Navigator.pushNamed(context, '/checkout');
                     },
                     style: ElevatedButton.styleFrom(
                       padding: EdgeInsets.symmetric(vertical: 16),
                       backgroundColor: AppTheme.primaryColor,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                     ),
                     child: Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   ),
                 ),
               ],
             ),
          )
        ],
      ),
    );
  }
}
