import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_app/Models/cart_model.dart';
import 'package:foodpanda_app/Models/menu_item_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title, String imagePath, String restaurantId) {
    if (_items.containsKey(productId)) {
      // update quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imagePath: existingCartItem.imagePath,
          restaurantId: existingCartItem.restaurantId,
        ),
      );
      Fluttertoast.showToast(
        msg: "Item quantity updated!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      // add new item
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          name: title,
          price: price,
          quantity: 1,
          imagePath: imagePath,
          restaurantId: restaurantId,
        ),
      );
      Fluttertoast.showToast(
        msg: "Item added to cart!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xffE5007D),
        textColor: Colors.white,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                name: existingCartItem.name,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                imagePath: existingCartItem.imagePath,
                restaurantId: existingCartItem.restaurantId,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
