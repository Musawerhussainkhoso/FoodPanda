import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';
import 'package:foodpanda_app/Providers/favorites_provider.dart';
import 'package:foodpanda_app/Screens/restaurant_detail_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _openRestaurant(BuildContext context, Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (_, favorites, __) {
          final favs = favorites.favorites;
          if (favs.isEmpty) {
            return const Center(
              child: Text(
                'No favourites yet.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final restaurant = favs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 1,
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _openRestaurant(context, restaurant),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              restaurant.imagePath,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 72,
                                height: 72,
                                color: Colors.grey[100],
                                child: const Icon(Icons.restaurant, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${restaurant.category} • ${restaurant.priceRange}',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.star_rounded,
                                        color: Colors.amber[500], size: 16),
                                    const SizedBox(width: 6),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite, color: AppTheme.primaryColor),
                            onPressed: () {
                              // In this screen, the restaurant is already a favourite; pressing removes it.
                              favorites.toggleFavorite(restaurant);
                              Fluttertoast.showToast(
                                msg: "Removed from favourites!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

