import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Providers/cart_provider.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant.name),
              background: Image.asset(
                restaurant.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey, child: Icon(Icons.restaurant, size: 50)),
              ),
            ),
            actions: [
               Consumer<CartProvider>(
                builder: (_, cart, ch) => Badge(
                  label: Text(cart.itemCount.toString()),
                  isLabelVisible: cart.itemCount > 0,
                  child: IconButton(
                    icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(restaurant.category, style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          Text('${restaurant.rating}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Popular Items', style: AppTheme.headline1.copyWith(fontSize: 20)),
                  SizedBox(height: 10),
                  // Mock Menu Items
                  _buildMenuItem(context, '1', 'Combo Meal', 15.99, 'assets/images/burgerking.png', 'Delicious combo', restaurant.id),
                  _buildMenuItem(context, '2', 'Family Pack', 29.99, 'assets/images/mcdonalds.png', 'Feast for the family', restaurant.id),
                  _buildMenuItem(context, '3', 'Spicy Burger', 8.99, 'assets/images/kfc.png', 'Hot and spicy', restaurant.id),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (ctx, cart, _) => cart.itemCount > 0 
          ? Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/cart'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${cart.itemCount} items'),
                    Text('View Cart'),
                    Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String id, String name, double price, String image, String desc, String restId) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (c,e,s) => Container(width: 80, height: 80, color: Colors.grey[200], child: Icon(Icons.fastfood, color: Colors.grey)),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 12), maxLines: 2),
                  SizedBox(height: 4),
                  Text('\$$price', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: AppTheme.primaryColor, size: 30),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addItem(id, price, name, image, restId);
              },
            )
          ],
        ),
      ),
    );
  }
}
