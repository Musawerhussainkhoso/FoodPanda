import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Widgets/CustomHeader.dart';

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
  bool _isAnimating = false;

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

  void _animateLogo() {
    if (_isAnimating) return;
    
    setState(() {
      _isAnimating = true;
    });
    
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _animateLogo,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedRotation(
            turns: _isAnimating ? 1 : 0,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/food.png",
                  width: 84,
                  height: 84,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.restaurant,
                        size: 40,
                        color: Color(0xffE5007D),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
    bool hasNotification = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Color(0xffE5007D).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: isActive ? Border.all(color: Color(0xffE5007D).withOpacity(0.3), width: 1) : null,
      ),
      child: ListTile(
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: isActive ? Color(0xffE5007D) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive ? [
              BoxShadow(
                color: Color(0xffE5007D).withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ] : null,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.grey[700],
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isActive ? Color(0xffE5007D) : Colors.grey[800],
            letterSpacing: 0.3,
          ),
        ),
        trailing: hasNotification 
            ? Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              )
            : Icon(
                Icons.chevron_right,
                color: isActive ? Color(0xffE5007D) : Colors.grey[400],
                size: 22,
              ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(),
      
      // UPDATED PROFESSIONAL DRAWER
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.82,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // DRAWER HEADER WITH PROFILE IMAGE
              Container(
                height: 180,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffE5007D),
                      Color(0xffFF0066),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffE5007D).withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileImage(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xffE5007D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        elevation: 3,
                        minimumSize: Size(160, 50),
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: Text(
                        'SIGN IN / REGISTER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // SCROLLABLE DRAWER CONTENT
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      
                      // MAIN SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'MAIN NAVIGATION',
                          style: TextStyle(
                            color: Color(0xffE5007D),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      
                      _buildDrawerItem(
                        icon: Icons.home_filled,
                        title: 'Home',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        isActive: true,
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.restaurant_menu,
                        title: 'Restaurants',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.shopping_basket,
                        title: 'Grocery',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        hasNotification: true,
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.local_offer,
                        title: 'Offers & Deals',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.favorite,
                        title: 'Favorites',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.history,
                        title: 'Order History',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      // DIVIDER WITH STYLE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1.5,
                          height: 0,
                        ),
                      ),
                      
                      // ACCOUNT SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'ACCOUNT SETTINGS',
                          style: TextStyle(
                            color: Color(0xffE5007D),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      
                      _buildDrawerItem(
                        icon: Icons.person,
                        title: 'Profile',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.location_pin,
                        title: 'Addresses',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.payment,
                        title: 'Payment Methods',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.headset_mic,
                        title: 'Help Center',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      _buildDrawerItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      
                      // BOTTOM SECTION - FIXED LINE WITH NULL ASSERTION
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!), // FIXED: Added null assertion
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Legal',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: Text(
                                      'Terms & Conditions',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.centerRight,
                                    ),
                                    child: Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // BODY (CORRECTED)
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Brands Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              'Top Brands',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
          ),
          
          // Top Brands Horizontal Scroll
          Container(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _allRestaurants.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                final restaurant = _allRestaurants[index];
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(restaurant.imagePath),
                          onBackgroundImageError: (exception, stackTrace) {
                            // Handle image loading error
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        restaurant.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search restaurants, cuisine, or dishes...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xffE5007D), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
            ),
          ),
          
          // All Restaurants Section - FIXED THE MISSING PARENTHESIS
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Restaurants',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  '${_filteredRestaurants.length} places',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Restaurants List - FIXED IMAGE ERROR HANDLING
          Expanded(
            child: _filteredRestaurants.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No restaurants found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Try a different search term',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = _filteredRestaurants[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                restaurant.imagePath,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[100],
                                    child: Center(
                                      child: Icon(
                                        Icons.restaurant,
                                        color: Colors.grey[400],
                                        size: 30,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            restaurant.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      restaurant.category,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 14),
                                      SizedBox(width: 2),
                                      Text(
                                        restaurant.rating.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.timer, size: 14, color: Colors.grey[500]),
                                  SizedBox(width: 4),
                                  Text(
                                    restaurant.deliveryTime,
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Icons.attach_money, size: 14, color: Colors.grey[500]),
                                  SizedBox(width: 4),
                                  Text(
                                    restaurant.priceRange,
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          onTap: () {
                            // Navigate to restaurant details screen
                            // TODO: Add navigation logic
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}