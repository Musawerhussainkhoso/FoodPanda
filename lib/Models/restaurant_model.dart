import 'menu_item_model.dart';

class Restaurant {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double rating;
  final String deliveryTime;
  final String priceRange;
  final List<MenuItem> menuItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.priceRange,
    this.menuItems = const [],
  });
}