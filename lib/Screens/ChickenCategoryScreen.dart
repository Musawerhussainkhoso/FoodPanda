import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/menu_item_model.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class ChickenCategoryScreen extends StatefulWidget {
  static const String routeName = '/chicken-category';

  @override
  _ChickenCategoryScreenState createState() => _ChickenCategoryScreenState();
}

class _ChickenCategoryScreenState extends State<ChickenCategoryScreen> {
  final List<Restaurant> _chickenRestaurants = [
    Restaurant(
      id: '3',
      name: 'KFC',
      imagePath: 'assets/images/kfc.png',
      category: 'Chicken • Fast Food',
      rating: 4.1,
      deliveryTime: '30-40 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'k1',
          name: 'Zinger Burger',
          price: '5.49',
          description:
              'Crispy fried chicken fillet with lettuce and mayo in a sesame seed bun',
          imagePath: 'assets/images/zinger.png',
          category: 'Chicken Burgers',
          isVeg: false,
          rating: 4.4,
          tags: ['Crispy', 'Spicy'],
          isSpicy: true,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'k2',
          name: 'Fried Chicken Bucket',
          price: '12.99',
          description: '8 pieces of original recipe fried chicken',
          imagePath: 'assets/images/chickenbucket.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.3,
          tags: ['Original Recipe', 'Shareable'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'k3',
          name: 'Popcorn Chicken',
          price: '4.49',
          description: 'Bite-sized crispy chicken pieces',
          imagePath: 'assets/images/popcornchicken.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.0,
          tags: ['Snack', 'Crispy'],
          isSpicy: false,
          isBestSeller: false,
        ),
        MenuItem(
          id: 'k4',
          name: 'Chicken Tenders',
          price: '5.99',
          description: 'Crispy chicken strips with dipping sauce',
          imagePath: 'assets/images/tenders.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.2,
          tags: ['Crispy'],
          isSpicy: false,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: '1',
      name: 'McDonald\'s',
      imagePath: 'assets/images/mcdonalds.png',
      category: 'Fast Food • Chicken',
      rating: 4.3,
      deliveryTime: '20-30 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'm3',
          name: 'McChicken',
          price: '4.99',
          description: 'Crispy chicken patty with lettuce and mayo',
          imagePath: 'assets/images/mcchicken.png',
          category: 'Chicken Burgers',
          isVeg: false,
          rating: 4.2,
          tags: ['Crispy'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'm5',
          name: 'Chicken McNuggets',
          price: '4.99',
          description: '10 pieces of crispy chicken nuggets with dipping sauce',
          imagePath: 'assets/images/nuggets.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.2,
          tags: ['Crispy', 'Shareable'],
          isSpicy: false,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: '2',
      name: 'Burger King',
      imagePath: 'assets/images/burgerking.png',
      category: 'Fast Food • Chicken',
      rating: 4.2,
      deliveryTime: '25-35 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'b5',
          name: 'Chicken Royale',
          price: '5.49',
          description: 'Crispy chicken fillet with lettuce and mayo',
          imagePath: 'assets/images/chickenroyale.png',
          category: 'Chicken Burgers',
          isVeg: false,
          rating: 4.1,
          tags: ['Crispy'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'b3',
          name: 'Chicken Fries',
          price: '3.99',
          description: 'Crispy seasoned chicken fries',
          imagePath: 'assets/images/chickenfries.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.1,
          tags: ['Crispy'],
          isSpicy: false,
          isBestSeller: false,
        ),
      ],
    ),
    Restaurant(
      id: 'c1',
      name: 'Nando\'s',
      imagePath: 'assets/images/nandos.png',
      category: 'Chicken • Portuguese',
      rating: 4.5,
      deliveryTime: '35-45 min',
      priceRange: 'R\$R\$',
      menuItems: [
        MenuItem(
          id: 'n1',
          name: 'Peri-Peri Chicken',
          price: '15.99',
          description: 'Flame-grilled chicken with peri-peri sauce',
          imagePath: 'assets/images/periperi.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.7,
          tags: ['Flame Grilled', 'Spicy'],
          isSpicy: true,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'n2',
          name: 'Chicken Wrap',
          price: '8.99',
          description: 'Grilled chicken wrap with peri-peri sauce',
          imagePath: 'assets/images/chickenwrap.png',
          category: 'Chicken Wraps',
          isVeg: false,
          rating: 4.4,
          tags: ['Grilled'],
          isSpicy: true,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: 'c2',
      name: 'Chicken Cottage',
      imagePath: 'assets/images/chickencottage.png',
      category: 'Chicken • Fast Food',
      rating: 3.9,
      deliveryTime: '25-35 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'cc1',
          name: 'Chicken Broast',
          price: '6.99',
          description: 'Crispy fried chicken pieces',
          imagePath: 'assets/images/broast.png',
          category: 'Chicken',
          isVeg: false,
          rating: 4.0,
          tags: ['Crispy'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'cc2',
          name: 'Chicken Roll',
          price: '3.49',
          description: 'Chicken roll with vegetables and sauce',
          imagePath: 'assets/images/chickenroll.png',
          category: 'Chicken Rolls',
          isVeg: false,
          rating: 3.8,
          tags: ['Quick'],
          isSpicy: false,
          isBestSeller: false,
        ),
      ],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _chickenRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRestaurants = _chickenRestaurants;
      } else {
        _filteredRestaurants = _chickenRestaurants
            .where(
              (restaurant) =>
                  restaurant.name.toLowerCase().contains(query) ||
                  restaurant.category.toLowerCase().contains(query) ||
                  restaurant.menuItems.any(
                    (item) =>
                        item.name.toLowerCase().contains(query) ||
                        item.description.toLowerCase().contains(query),
                  ),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chicken',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${_chickenRestaurants.length} chicken restaurants',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[800],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search chicken restaurants...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.red[800],
                          size: 18,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.red[800],
                      size: 18,
                    ),
                    onSelected: (value) {
                      _sortRestaurants(value);
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'rating',
                        child: Text('Highest Rated'),
                      ),
                      PopupMenuItem(
                        value: 'delivery',
                        child: Text('Fastest Delivery'),
                      ),
                      PopupMenuItem(
                        value: 'price',
                        child: Text('Price: Low to High'),
                      ),
                      PopupMenuItem(value: 'name', child: Text('Alphabetical')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  void _sortRestaurants(String sortBy) {
    setState(() {
      switch (sortBy) {
        case 'rating':
          _filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'delivery':
          _filteredRestaurants.sort((a, b) {
            final aTime = int.parse(a.deliveryTime.split('-').first);
            final bTime = int.parse(b.deliveryTime.split('-').first);
            return aTime.compareTo(bTime);
          });
          break;
        case 'price':
          _filteredRestaurants.sort(
            (a, b) => a.priceRange.length.compareTo(b.priceRange.length),
          );
          break;
        case 'name':
          _filteredRestaurants.sort((a, b) => a.name.compareTo(b.name));
          break;
      }
    });
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats Section
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          color: Colors.red[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.star, '4.2', 'Avg. Rating'),
              _buildStatItem(Icons.access_time, '30 min', 'Avg. Delivery'),
              _buildStatItem(Icons.attach_money, 'R\$R\$', 'Avg. Price'),
              _buildStatItem(Icons.kebab_dining, '25+', 'Chicken Dishes'),
            ],
          ),
        ),

        // Specials Banner
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[800]!, Colors.orange[700]!],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.local_offer, color: Colors.white, size: 24),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chicken Lovers!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Special chicken bucket deals available',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),

        // Restaurant Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            '${_filteredRestaurants.length} restaurants found',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),

        // Restaurant List
        Expanded(
          child: _filteredRestaurants.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.kebab_dining,
                        size: 60,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No chicken restaurants found',
                        style: TextStyle(color: Colors.grey[500], fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Try a different search term',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  itemCount: _filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantCard(_filteredRestaurants[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.red[800], size: 24),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
      ],
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    final chickenCount = restaurant.menuItems
        .where((item) => item.category.toLowerCase().contains('chicken'))
        .length;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(restaurant.imagePath),
                    fit: BoxFit.cover,
                    onError: (_, __) => Container(
                      color: Colors.grey[100],
                      child: Icon(Icons.kebab_dining, color: Colors.grey[300]),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12),

              // Restaurant Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                restaurant.rating.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.category, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          restaurant.category,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.access_time, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          restaurant.deliveryTime,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.kebab_dining, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '$chickenCount chicken items',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Popular Chicken Items
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: restaurant.menuItems
                          .where((item) => item.isBestSeller)
                          .take(3)
                          .map(
                            (item) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.red[100]!),
                              ),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: Colors.red[800],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    SizedBox(height: 8),

                    // Price and CTA
                    Row(
                      children: [
                        Text(
                          restaurant.priceRange,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text('•', style: TextStyle(color: Colors.grey[400])),
                        SizedBox(width: 4),
                        Text(
                          'Free delivery',
                          style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[800],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'View Menu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
