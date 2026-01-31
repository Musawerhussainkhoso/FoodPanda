import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/menu_item_model.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

class PizzaCategoryScreen extends StatefulWidget {
  static const String routeName = '/pizza-category';

  @override
  _PizzaCategoryScreenState createState() => _PizzaCategoryScreenState();
}

class _PizzaCategoryScreenState extends State<PizzaCategoryScreen> {
  final List<Restaurant> _pizzaRestaurants = [
    Restaurant(
      id: '4',
      name: 'Domino\'s Pizza',
      imagePath: 'assets/images/dominos.png',
      category: 'Pizza • Fast Food',
      rating: 4.4,
      deliveryTime: '20-30 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'd1',
          name: 'Pepperoni Pizza',
          price: '10.99',
          description: 'Classic pizza loaded with pepperoni and extra cheese',
          imagePath: 'assets/images/pepperoni.png',
          category: 'Pizza',
          isVeg: false,
          rating: 4.6,
          tags: ['Classic', 'Meat Lovers'],
          isSpicy: true,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'd2',
          name: 'Margherita Pizza',
          price: '8.99',
          description: 'Simple pizza with tomato sauce, mozzarella cheese, and fresh basil',
          imagePath: 'assets/images/margherita.png',
          category: 'Pizza',
          isVeg: true,
          rating: 4.3,
          tags: ['Vegetarian', 'Classic'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'd3',
          name: 'Veg Supreme Pizza',
          price: '9.99',
          description: 'Loaded with fresh vegetables and cheese',
          imagePath: 'assets/images/vegsupreme.png',
          category: 'Pizza',
          isVeg: true,
          rating: 4.2,
          tags: ['Vegetarian'],
          isSpicy: false,
          isBestSeller: false,
        ),
        MenuItem(
          id: 'd4',
          name: 'BBQ Chicken Pizza',
          price: '11.99',
          description: 'Grilled chicken with BBQ sauce and onions',
          imagePath: 'assets/images/bbqchickenpizza.png',
          category: 'Pizza',
          isVeg: false,
          rating: 4.5,
          tags: ['Chicken', 'BBQ'],
          isSpicy: false,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: 'p1',
      name: 'Pizza Hut',
      imagePath: 'assets/images/pizzahut.png',
      category: 'Pizza • Italian',
      rating: 4.3,
      deliveryTime: '25-35 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'ph1',
          name: 'Stuffed Crust Pizza',
          price: '12.99',
          description: 'Pizza with cheese-filled crust',
          imagePath: 'assets/images/stuffedcrust.png',
          category: 'Pizza',
          isVeg: true,
          rating: 4.5,
          tags: ['Cheesy Crust'],
          isSpicy: false,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'ph2',
          name: 'Supreme Pizza',
          price: '13.99',
          description: 'Loaded with pepperoni, sausage, peppers, onions, and mushrooms',
          imagePath: 'assets/images/supreme.png',
          category: 'Pizza',
          isVeg: false,
          rating: 4.4,
          tags: ['Loaded', 'Meat Lovers'],
          isSpicy: true,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: 'p2',
      name: 'Papa John\'s',
      imagePath: 'assets/images/papajohns.png',
      category: 'Pizza • American',
      rating: 4.2,
      deliveryTime: '30-40 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'pj1',
          name: 'The Works Pizza',
          price: '14.99',
          description: 'Pepperoni, sausage, mushrooms, onions, green peppers, and black olives',
          imagePath: 'assets/images/workspizza.png',
          category: 'Pizza',
          isVeg: false,
          rating: 4.4,
          tags: ['Loaded'],
          isSpicy: true,
          isBestSeller: true,
        ),
      ],
    ),
    Restaurant(
      id: 'p3',
      name: 'Little Caesars',
      imagePath: 'assets/images/littlecaesars.png',
      category: 'Pizza • Budget',
      rating: 3.9,
      deliveryTime: '15-25 min',
      priceRange: 'R\$',
      menuItems: [
        MenuItem(
          id: 'lc1',
          name: 'Hot-N-Ready Pizza',
          price: '5.99',
          description: 'Ready-to-eat pepperoni pizza',
          imagePath: 'assets/images/hotnready.png',
          category: 'Pizza',
          isVeg: false,
          rating: 3.8,
          tags: ['Budget', 'Quick'],
          isSpicy: true,
          isBestSeller: true,
        ),
        MenuItem(
          id: 'lc2',
          name: 'ExtraMostBestest Pizza',
          price: '7.99',
          description: 'Extra cheese and pepperoni',
          imagePath: 'assets/images/extramost.png',
          category: 'Pizza',
          isVeg: false,
          rating: 4.0,
          tags: ['Cheesy'],
          isSpicy: true,
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
    _filteredRestaurants = _pizzaRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRestaurants = _pizzaRestaurants;
      } else {
        _filteredRestaurants = _pizzaRestaurants
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query) ||
                restaurant.category.toLowerCase().contains(query) ||
                restaurant.menuItems.any((item) =>
                    item.name.toLowerCase().contains(query) ||
                    item.description.toLowerCase().contains(query)))
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
              'Pizza',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${_pizzaRestaurants.length} pizza restaurants',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange[700],
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
                        hintText: 'Search pizza restaurants...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.orange[700],
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
                      color: Colors.orange[700],
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
                      PopupMenuItem(
                        value: 'name',
                        child: Text('Alphabetical'),
                      ),
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
          color: Colors.orange[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.star, '4.2', 'Avg. Rating'),
              _buildStatItem(Icons.access_time, '25 min', 'Avg. Delivery'),
              _buildStatItem(Icons.attach_money, 'R\$', 'Avg. Price'),
              _buildStatItem(Icons.local_pizza, '15+', 'Pizza Types'),
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
                colors: [Colors.orange[700]!, Colors.deepOrange[400]!],
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
                        'Pizza Deal!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Buy 1 Get 1 Free on all medium pizzas',
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
            '${_filteredRestaurants.length} pizza restaurants found',
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
                      Icon(Icons.local_pizza, size: 60, color: Colors.grey[300]),
                      SizedBox(height: 16),
                      Text(
                        'No pizza restaurants found',
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
        Icon(icon, color: Colors.orange[700], size: 24),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    final pizzaCount = restaurant.menuItems
        .where((item) => item.category.toLowerCase().contains('pizza'))
        .length;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
                      child: Icon(Icons.local_pizza, color: Colors.grey[300]),
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
                            color: Colors.orange[100],
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
                        Icon(Icons.local_pizza, size: 12, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '$pizzaCount pizza types',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Popular Pizzas
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: restaurant.menuItems
                          .where((item) => item.isBestSeller)
                          .take(2)
                          .map(
                            (item) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.orange[200]!,
                                ),
                              ),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: Colors.orange[700],
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
                            color: Colors.orange[700],
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
                            color: Colors.orange[700],
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