import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/menu_item_model.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class FastFoodCategoryScreen extends StatefulWidget {
  static const String routeName = '/fastfood-category';

  @override
  _FastFoodCategoryScreenState createState() => _FastFoodCategoryScreenState();
}

class _FastFoodCategoryScreenState extends State<FastFoodCategoryScreen> {
  final List<Restaurant> _fastFoodRestaurants = [
    Restaurant(
      id: '1',
      name: 'McDonald\'s',
      imagePath: 'assets/images/mcdonalds.png',
      category: 'Fast Food • Burgers',
      rating: 4.3,
      deliveryTime: '20-30 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'm1',
          name: 'Big Mac',
          price: '5.99',
          description:
              'Two 100% beef patties, special sauce, lettuce, cheese, pickles, onions on a sesame seed bun',
          imagePath: 'assets/images/bigmac.png',
          category: 'Burgers',
          isVeg: false,
          rating: 4.5,
          tags: ['Signature', 'Best Seller'],
          isSpicy: false,
          isBestSeller: true,
        ),
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
          id: 'm4',
          name: 'French Fries',
          price: '2.99',
          description: 'Crispy golden fries with salt',
          imagePath: 'assets/images/fries.png',
          category: 'Sides',
          isVeg: true,
          rating: 4.7,
          tags: ['Classic'],
          isSpicy: false,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: '2',
      name: 'Burger King',
      imagePath: 'assets/images/burgerking.png',
      category: 'Fast Food • Burgers',
      rating: 4.2,
      deliveryTime: '25-35 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'b1',
          name: 'Whopper',
          price: '6.99',
          description:
              'Flame-grilled beef patty with tomatoes, lettuce, mayo, ketchup, pickles, and onions',
          imagePath: 'assets/images/whopper.png',
          category: 'Burgers',
          isVeg: false,
          rating: 4.7,
          tags: ['Signature', 'Flame Grilled'],
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
        MenuItem(
          id: 'b4',
          name: 'Onion Rings',
          price: '2.49',
          description: 'Crispy battered onion rings',
          imagePath: 'assets/images/onionrings.png',
          category: 'Sides',
          isVeg: true,
          rating: 4.3,
          tags: ['Crispy'],
          isSpicy: false,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: '4',
      name: 'Domino\'s',
      imagePath: 'assets/images/dominos.png',
      category: 'Fast Food • Pizza',
      rating: 4.4,
      deliveryTime: '20-30 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'd1',
          name: 'Pepperoni Pizza',
          price: '10.99',
          description: 'Classic pizza loaded with pepperoni and cheese',
          imagePath: 'assets/images/pepperoni.png',
          category: 'Pizza',
          isVeg: false,
          rating: 4.6,
          tags: ['Classic', 'Cheesy'],
          isSpicy: true,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'd5',
          name: 'Garlic Breadsticks',
          price: '4.99',
          description: 'Soft breadsticks with garlic butter',
          imagePath: 'assets/images/garlicbread.png',
          category: 'Sides',
          isVeg: true,
          rating: 4.4,
          tags: ['Garlic'],
          isSpicy: false,
          isBestSeller: true,
        ),
      ],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _fastFoodRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRestaurants = _fastFoodRestaurants;
      } else {
        _filteredRestaurants = _fastFoodRestaurants
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
              'Fast Food',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${_fastFoodRestaurants.length} fast food restaurants',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
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
                        hintText: 'Search fast food restaurants...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.red[600],
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
                      color: Colors.red[600],
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
              _buildStatItem(Icons.star, '4.1', 'Avg. Rating'),
              _buildStatItem(Icons.access_time, '25 min', 'Avg. Delivery'),
              _buildStatItem(Icons.attach_money, 'R\$', 'Avg. Price'),
              _buildStatItem(Icons.fastfood, '50+', 'Menu Items'),
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
                colors: [Colors.red[600]!, Colors.orange[600]!],
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
                        'Fast Food Frenzy!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Free delivery on orders above R\$20',
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
                      Icon(Icons.search_off, size: 60, color: Colors.grey[300]),
                      SizedBox(height: 16),
                      Text(
                        'No fast food restaurants found',
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
        Icon(icon, color: Colors.red[600], size: 24),
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
                      child: Icon(Icons.restaurant, color: Colors.grey[300]),
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
                        Icon(Icons.fastfood, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '${restaurant.menuItems.length} items',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Popular Items
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
                                  color: Colors.red[600],
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
                            color: Colors.red[600],
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
                            color: Colors.red[600],
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
