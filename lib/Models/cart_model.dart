import 'package:foodpanda_app/Models/menu_item_model.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imagePath;
  final String restaurantId;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.restaurantId,
  });

  double get totalPrice => price * quantity;
}
