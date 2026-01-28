import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/menu_item_model.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class BurgerCategoryScreen extends StatefulWidget {
  static const String routeName = '/burger-category';

  @override
  _BurgerCategoryScreenState createState() => _BurgerCategoryScreenState();
}

class _BurgerCategoryScreenState extends State<BurgerCategoryScreen> {
  // List of restaurants that serve burgers
  final List<Restaurant> _burgerRestaurants = [
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
          id: 'm2',
          name: 'Quarter Pounder',
          price: '6.49',
          description:
              'Quarter pound beef patty with cheese, onions, pickles, mustard, and ketchup',
          imagePath: 'assets/images/quarterpounder.png',
          category: 'Burgers',
          isVeg: false,
          rating: 4.3,
          tags: ['Cheesy'],
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
              'Flame-grilled beef patty topped with tomatoes, lettuce, mayo, ketchup, pickles, and onions',
          imagePath: 'assets/images/whopper.png',
          category: 'Burgers',
          isVeg: false,
          rating: 4.7,
          tags: ['Signature', 'Flame Grilled'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'b2',
          name: 'Double Cheeseburger',
          price: '4.99',
          description:
              'Two beef patties, two slices of American cheese, pickles, ketchup, and mustard',
          imagePath: 'assets/images/doublecheese.png',
          category: 'Burgers',
          isVeg: false,
          rating: 4.2,
          tags: ['Cheesy'],
          isSpicy: false,
          isBestSeller: false,
        ),
      ],
    ),
    Restaurant(
      id: '3',
      name: 'KFC',
      imagePath: 'assets/images/kfc.png',
      category: 'Chicken • Burgers',
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
      ],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _burgerRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRestaurants = _burgerRestaurants;
      } else {
        _filteredRestaurants = _burgerRestaurants
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
    final isDesktop = MediaQuery.of(context).size.width > 800;

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
              'Burgers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${_burgerRestaurants.length} restaurants serving burgers',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
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
                        hintText: 'Search burger restaurants...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppTheme.primaryColor,
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
                      color: AppTheme.primaryColor,
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
      body: _buildBody(isDesktop),
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

  Widget _buildBody(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats Section
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          color: Colors.grey[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.star, '4.4', 'Avg. Rating'),
              _buildStatItem(Icons.access_time, '28 min', 'Avg. Delivery'),
              _buildStatItem(Icons.attach_money, 'R\$', 'Avg. Price'),
              _buildStatItem(Icons.restaurant, '50+', 'Burger Types'),
            ],
          ),
        ),

        // Burger Specials Banner
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, Color(0xFFFBB03B)],
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
                        'Burger Deals!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Get 20% off on all burger orders above R\$15',
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
                        'No burger restaurants found',
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
        Icon(icon, color: AppTheme.primaryColor, size: 24),
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
    // Count burger items
    final burgerCount = restaurant.menuItems
        .where((item) => item.category.toLowerCase().contains('burger'))
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
                            color: AppTheme.primaryColor.withOpacity(0.1),
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
                        Icon(
                          Icons.local_restaurant,
                          size: 12,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '$burgerCount burger types',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Burger Specialties
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: restaurant.menuItems
                          .where(
                            (item) =>
                                item.isBestSeller &&
                                item.category.toLowerCase().contains('burger'),
                          )
                          .take(3)
                          .map(
                            (item) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppTheme.primaryColor.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
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
                            color: AppTheme.primaryColor,
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
                            color: AppTheme.primaryColor,
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
