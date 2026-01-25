import 'package:flutter/material.dart';
import 'package:foodpanda_app/Screens/Login_Screen.dart';
import 'package:foodpanda_app/Screens/home_screen.dart';
// Import home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Express',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Poppins',
      ),
      home: LoginScreen(), // Start with login
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Add home route
      },
    );
  }
}