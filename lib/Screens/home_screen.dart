import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Providers/cart_provider.dart';
import 'package:foodpanda_app/Screens/burger_category_screen.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Restaurant> _allRestaurants = [
    Restaurant(
      id: '1',
      name: 'McDonald\'s',
      imagePath: 'assets/images/mcdonalds.png',
      category: 'Fast Food',
      rating: 4.3,
      deliveryTime: '20-30 min',
      priceRange: 'R\$',
    ),
    Restaurant(
      id: '2',
      name: 'Burger King',
      imagePath: 'assets/images/burgerking.png',
      category: 'Fast Food',
      rating: 4.2,
      deliveryTime: '25-35 min',
      priceRange: 'R\$',
    ),
    Restaurant(
      id: '3',
      name: 'KFC',
      imagePath: 'assets/images/kfc.png',
      category: 'Fast Food',
      rating: 4.1,
      deliveryTime: '30-40 min',
      priceRange: 'R\$',
    ),
    Restaurant(
      id: '4',
      name: 'Domino\'s',
      imagePath: 'assets/images/dominos.png',
      category: 'Pizza',
      rating: 4.4,
      deliveryTime: '20-30 min',
      priceRange: 'R\$',
    ),
    Restaurant(
      id: '5',
      name: 'Subway',
      imagePath: 'assets/images/subway.png',
      category: 'Healthy',
      rating: 4.0,
      deliveryTime: '15-25 min',
      priceRange: 'R\$',
    ),
  ];

  List<Restaurant> _filteredRestaurants = [];
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _allRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredRestaurants = _allRestaurants;
      } else {
        _filteredRestaurants = _allRestaurants
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query) ||
                restaurant.category.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Define _buildDrawer inside the state class
  Widget _buildDrawer() {
    return Drawer(
      width: 280,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppTheme.primaryColor),
            margin: EdgeInsets.zero,
            accountName: Text('Guest User', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text('Sign in for more features'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: AppTheme.primaryColor),
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text('Home'), onTap: () => Navigator.pop(context)),
          ListTile(leading: Icon(Icons.favorite), title: Text('Favorites'), onTap: () {}),
          ListTile(leading: Icon(Icons.history), title: Text('Orders'), onTap: () {}),
          Divider(),
          ListTile(leading: Icon(Icons.settings), title: Text('Settings'), onTap: () {}),
          ListTile(leading: Icon(Icons.help), title: Text('Help'), onTap: () {}),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isDesktop ? null : _buildDrawer(),
      body: CustomScrollView(
        slivers: [
          // STICKY APP BAR
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: isDesktop ? 120.0 : 130.0,
            backgroundColor: AppTheme.primaryColor,
            elevation: 0,
            title: Row(
              children: [
                if (!isDesktop) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivering to', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.white70)),
                      Row(
                        children: [
                          Text('Home • 123 Street', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ] else ...[
                   Text('FoodPanda', style: AppTheme.headline1.copyWith(color: Colors.white)),
                   Spacer(),
                   _buildDesktopNavItem('Home'),
                   _buildDesktopNavItem('Delivery'),
                   _buildDesktopNavItem('Pick-Up'),
                   _buildDesktopNavItem('Dine-In'),
                ]
              ],
            ),
            actions: [
              Consumer<CartProvider>(
                builder: (_, cart, ch) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Center(
                    child: Badge(
                      label: Text(cart.itemCount.toString()),
                      isLabelVisible: cart.itemCount > 0,
                      child: IconButton(
                        icon: Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 22),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              if (isDesktop) 
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Center(child: ElevatedButton(onPressed: (){}, child: Text("Login"), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.primaryColor))),
                )
              else
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child: IconButton(icon: Icon(Icons.person_outline, color: Colors.white), onPressed: () {}),
                 )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(65),
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
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Search for shops & restaurants',
                            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                            prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor, size: 18),
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
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.tune, color: AppTheme.primaryColor, size: 18),
                        onPressed: () {
                          // Filter logic
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // HERO SECTION
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HERO BANNER CAROUSEL
                SizedBox(height: 15),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 160.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: isDesktop ? 0.4 : 0.88,
                    aspectRatio: 16/9,
                    initialPage: 0,
                  ),
                  items: [
                    'assets/images/burgerking.png', 
                    'assets/images/mcdonalds.png', 
                    'assets/images/kfc.png',
                    'assets/images/dominos.png'
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.pink[50], 
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(i),
                              fit: BoxFit.cover,
                              onError: (_,__) {} 
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                              ),
                            ),
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FLASH DEAL',
                                  style: TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.w900, backgroundColor: Colors.white, letterSpacing: 1),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '50% OFF TODAY!',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                // CUISINES
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cuisines', style: AppTheme.headline1.copyWith(fontSize: 18)),
                      TextButton(onPressed: () {}, child: Text('View all', style: TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildCuisineItem('Burgers', 'assets/images/burgerking.png'),
                      _buildCuisineItem('Pizza', 'assets/images/dominos.png'),
                      _buildCuisineItem('Healthy', 'assets/images/subway.png'),
                      _buildCuisineItem('Fast Food', 'assets/images/mcdonalds.png'),
                      _buildCuisineItem('Chicken', 'assets/images/kfc.png'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('All Restaurants', style: AppTheme.headline1.copyWith(fontSize: 20)),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // RESTAURANT LIST
          _filteredRestaurants.isEmpty 
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(child: Text("No restaurants found")),
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 100), 
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                      childAspectRatio: isDesktop ? 0.85 : 0.88, 
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _buildRestaurantCard(_filteredRestaurants[index]);
                      },
                      childCount: _filteredRestaurants.length,
                    ),
                  ),
                ),
        ],
      ),
      
      bottomNavigationBar: isDesktop ? null : BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 2) { // Assuming Cart is index 2 or whatever
               // Handle nav
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDesktopNavItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () {},
        child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

Widget _buildCuisineItem(String name, String imagePath) {
  return GestureDetector(
    onTap: () {
      if (name == 'Burgers') {
        // Navigate to BurgerCategoryScreen
        Navigator.pushNamed(context, BurgerCategoryScreen.routeName);
      } else {
        // Handle other categories
      }
    },
    child: Container(
      width: 80,
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(imagePath),
              onBackgroundImageError: (_, __) {},
              child: Icon(Icons.fastfood, color: Colors.grey[300]),
            ),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12), overflow: TextOverflow.ellipsis),
        ],
      ),
    ),
  );
}

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      restaurant.imagePath,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          color: Colors.grey[100],
                          child: Center(child: Icon(Icons.restaurant, size: 40, color: Colors.grey[300])),
                        );
                      },
                    ),
                  ),
                  // Discount Tag
                  Positioned(
                    top: 12,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                      ),
                      child: Text(
                        '20% OFF',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  // Delivery Time
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time_rounded, size: 12, color: Colors.grey[800]),
                          SizedBox(width: 4),
                          Text(
                            restaurant.deliveryTime,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite Button
                   Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite_border, size: 18, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              
              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  restaurant.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.black87,
                                    letterSpacing: -0.3,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (restaurant.rating > 4.2)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(Icons.verified, size: 16, color: Colors.blue[400]),
                                ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${restaurant.category} • ${restaurant.priceRange}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.star_rounded, color: Colors.amber[600], size: 18),
                          SizedBox(width: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' (500+)',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Free Delivery',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
