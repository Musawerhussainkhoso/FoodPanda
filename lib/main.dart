import 'package:flutter/material.dart';
import 'package:foodpanda_app/Providers/cart_provider.dart';
import 'package:foodpanda_app/Screens/ChickenCategoryScreen.dart';
import 'package:foodpanda_app/Screens/Login_Screen.dart';
import 'package:foodpanda_app/Screens/PizzaCategoryScreen.dart';
import 'package:foodpanda_app/Screens/burger_category_screen.dart';
import 'package:foodpanda_app/Screens/cart_screen.dart';
import 'package:foodpanda_app/Screens/fastfoodcategory.dart';
import 'package:foodpanda_app/Screens/home_screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Express',
        theme: AppTheme.lightTheme,
        home: LoginScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
          '/burger-category': (context) => BurgerCategoryScreen(),
          '/fastfood-category': (context) => FastFoodCategoryScreen(),
          '/pizza-category': (context) => PizzaCategoryScreen(),
          '/chicken-category': (context) => ChickenCategoryScreen(),
        },
      ),
    );
  }
}
