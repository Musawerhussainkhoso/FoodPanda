class MenuItem {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imagePath;
  final String category;
  final bool isVeg;
  final double rating;
  final List<String> tags;
  final bool isSpicy;
  final bool isBestSeller;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.category,
    this.isVeg = true,
    this.rating = 4.0,
    this.tags = const [],
    this.isSpicy = false,
    this.isBestSeller = false,
  });
}