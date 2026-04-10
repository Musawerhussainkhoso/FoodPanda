import 'package:flutter/material.dart';
import 'package:foodpanda_app/Models/restaurant_model.dart';

class FavoritesProvider with ChangeNotifier {
  final Map<String, Restaurant> _favoriteRestaurants = {};

  List<Restaurant> get favorites => _favoriteRestaurants.values.toList();

  bool isFavorite(String restaurantId) => _favoriteRestaurants.containsKey(restaurantId);

  void toggleFavorite(Restaurant restaurant) {
    if (isFavorite(restaurant.id)) {
      _favoriteRestaurants.remove(restaurant.id);
    } else {
      _favoriteRestaurants[restaurant.id] = restaurant;
    }
    notifyListeners();
  }
}

