import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Providers/cart_provider.dart';
import 'package:foodpanda_app/Providers/favorites_provider.dart';
import 'package:foodpanda_app/Providers/profile_provider.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
  final ScrollController _scrollController = ScrollController();
  String _selectedAddress = 'Personal · 123 Street';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _allRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRestaurants = _allRestaurants.where((restaurant) {
        final matchesQuery = query.isEmpty ||
            restaurant.name.toLowerCase().contains(query) ||
            restaurant.category.toLowerCase().contains(query);
            
        bool matchesCategory = true;
        if (_selectedCategory != 'All') {
          if (_selectedCategory == 'Burgers') {
            matchesCategory = restaurant.name.contains('Burger') || restaurant.name.contains('McDonald');
          } else if (_selectedCategory == 'Chicken') {
            matchesCategory = restaurant.name.contains('KFC');
          } else {
            matchesCategory = restaurant.category == _selectedCategory;
          }
        }
        
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  IconData _addressLeadingIcon(String address) {
    if (address.startsWith('Office')) return Icons.work_outline_rounded;
    if (address.startsWith('Hostel')) return Icons.apartment_rounded;
    return Icons.home_work_outlined;
  }

  Widget _drawerSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Colors.grey[600],
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        elevation: 0,
        shadowColor: Colors.black12,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: -0.2,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                )
              : null,
          trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: 300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(22)),
      ),
      backgroundColor: const Color(0xFFF4F4F5),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<ProfileProvider>(
              builder: (context, profile, child) => Material(
                color: AppTheme.primaryColor,
                child: InkWell(
                  onTap: () {
                    final nav = Navigator.of(context);
                    nav.pop();
                    nav.pushNamed('/profile');
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Icon(
                          Icons.restaurant_rounded,
                          size: 120,
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 16, 22),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage: profile.hasProfileImage
                                  ? MemoryImage(
                                      base64Decode(profile.profileImageBase64!),
                                    )
                                  : null,
                              child: !profile.hasProfileImage
                                  ? Icon(
                                      Icons.person_rounded,
                                      size: 34,
                                      color: AppTheme.primaryColor,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, ${profile.name.split(' ').first}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: -0.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    profile.email,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.88),
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'View account',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                children: [
                  _drawerSectionTitle('OFFERS & REWARDS'),
                  _drawerTile(
                    icon: Icons.confirmation_number_outlined,
                    title: 'Vouchers & offers',
                    subtitle: 'Save on your next order',
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'No vouchers yet — check back soon!',
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                      );
                    },
                  ),
                  _drawerTile(
                    icon: Icons.card_giftcard_rounded,
                    title: 'Invite friends',
                    subtitle: 'Share the app & earn rewards',
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'Invite link would be shared from here',
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.white,
                      );
                    },
                  ),
                  _drawerSectionTitle('YOUR ORDERS'),
                  _drawerTile(
                    icon: Icons.favorite_outline_rounded,
                    title: 'Favorites',
                    subtitle: 'Restaurants you love',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/favorites');
                    },
                  ),
                  _drawerTile(
                    icon: Icons.receipt_long_rounded,
                    title: 'Order history',
                    subtitle: 'Track past deliveries',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/orders');
                    },
                  ),
                  _drawerSectionTitle('SUPPORT'),
                  _drawerTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Help center',
                    subtitle: 'FAQs & contact',
                    onTap: () {
                      final nav = Navigator.of(context);
                      nav.pop();
                      nav.pushNamed('/help');
                    },
                  ),
                  _drawerTile(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'Notifications, language & more',
                    onTap: () {
                      final nav = Navigator.of(context);
                      nav.pop();
                      nav.pushNamed('/settings');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delivery_dining_rounded,
                          size: 18, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(
                        'Food Express',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressSelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final addresses = [
          'Personal · 123 Street',
          'Office · Downtown',
          'Hostel · Block A',
        ];
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: AppTheme.primaryColor,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Deliver to',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Choose where we should bring your order.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...addresses.map(
                (address) => ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor:
                        AppTheme.primaryColor.withOpacity(0.12),
                    child: Icon(
                      _addressLeadingIcon(address),
                      color: AppTheme.primaryColor,
                      size: 22,
                    ),
                  ),
                  title: Text(
                    address,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedAddress = address;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // STICKY APP BAR
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 118.0,
            backgroundColor: AppTheme.primaryColor,
            elevation: 0,
            centerTitle: false,
            titleSpacing: 8,
            leading: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              tooltip: 'Menu',
            ),
            title: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _showAddressSelector,
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Delivering to',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.75),
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                _selectedAddress,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(Icons.person_outline, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: double.infinity,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Search for shops & restaurants',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppTheme.primaryColor,
                                  size: 18,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.tune,
                              color: AppTheme.primaryColor,
                              size: 18,
                            ),
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
                    viewportFraction: 0.88,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                  ),
                  items:
                      [
                        'assets/images/burgerking.png',
                        'assets/images/mcdonalds.png',
                        'assets/images/kfc.png',
                        'assets/images/dominos.png',
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
                                  onError: (_, __) {},
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
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
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        backgroundColor: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '50% OFF TODAY!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                      Text(
                        'Cuisines',
                        style: AppTheme.headline1.copyWith(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildCuisineItem(
                        'Burgers',
                        'assets/images/burgerking.png',
                      ),
                      _buildCuisineItem('Pizza', 'assets/images/dominos.png'),
                      _buildCuisineItem('Healthy', 'assets/images/subway.png'),
                      _buildCuisineItem(
                        'Fast Food',
                        'assets/images/mcdonalds.png',
                      ),
                      _buildCuisineItem('Chicken', 'assets/images/kfc.png'),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _selectedCategory == 'All'
                        ? 'All Restaurants'
                        : _selectedCategory,
                    style: AppTheme.headline1.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // RESTAURANT LIST
          _filteredRestaurants.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No restaurants match',
                          textAlign: TextAlign.center,
                          style: AppTheme.headline1.copyWith(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try another search or clear filters.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {
                            _searchController.clear();
                            _selectedCategory = 'All';
                            _filterRestaurants();
                          },
                          icon: const Icon(Icons.refresh_rounded, size: 20),
                          label: const Text('Reset search'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryColor,
                            side: BorderSide(
                              color: AppTheme.primaryColor.withOpacity(0.5),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 32),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildRestaurantCard(
                            _filteredRestaurants[index],
                          ),
                        );
                      },
                      childCount: _filteredRestaurants.length,
                    ),
                  ),
                ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey[500],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 12,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 0) {
            setState(() {
              _currentIndex = 0;
            });
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          } else if (index == 1) {
            setState(() {
              _currentIndex = 0;
            });
            Navigator.pushNamed(context, '/orders');
          } else if (index == 2) {
            setState(() {
              _currentIndex = 0;
            });
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0
                  ? Icons.explore_rounded
                  : Icons.explore_outlined,
            ),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long_rounded),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineItem(String name, String imagePath) {
    bool isSelected = _selectedCategory == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedCategory == name) {
            _selectedCategory = 'All';
          } else {
            _selectedCategory = name;
          }
          _filterRestaurants();
        });
      },
      child: Container(
        width: 80,
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
                shape: BoxShape.circle,
                border: isSelected ? Border.all(color: AppTheme.primaryColor, width: 2) : Border.all(color: Colors.transparent, width: 2),
              ),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(imagePath),
                  onBackgroundImageError: (_, __) {},
                  child: !isSelected ? Icon(Icons.fastfood, color: Colors.grey[300]) : null,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, 
                fontSize: 12,
                color: isSelected ? AppTheme.primaryColor : Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    void openRestaurant() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
        ),
      );
    }

    return Container(
      height: 140, // Fixed height for structured horizontal structure
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section (tap opens restaurant)
            SizedBox(
              width: 130,
              child: InkWell(
                onTap: openRestaurant,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.asset(
                        restaurant.imagePath,
                        width: 130,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 130,
                            height: double.infinity,
                            color: Colors.grey[100],
                            child: Center(
                              child: Icon(
                                Icons.restaurant,
                                size: 40,
                                color: Colors.grey[300],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Delivery Time Tag
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 12,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.deliveryTime,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: openRestaurant,
                            borderRadius: BorderRadius.circular(8),
                            child: Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Consumer<FavoritesProvider>(
                          builder: (_, favorites, __) {
                            final isFavorite = favorites.isFavorite(restaurant.id);
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                size: 20,
                                color: isFavorite ? AppTheme.primaryColor : Colors.grey,
                              ),
                              onPressed: () {
                                favorites.toggleFavorite(restaurant);
                                Fluttertoast.showToast(
                                  msg: isFavorite
                                      ? "Removed from favourites!"
                                      : "Added to favourites!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: isFavorite ? Colors.black : Color(0xffE5007D),
                                  textColor: Colors.white,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${restaurant.category} • ${restaurant.priceRange}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber[500],
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          ' (500+)',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Free Delivery',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '20% OFF',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
