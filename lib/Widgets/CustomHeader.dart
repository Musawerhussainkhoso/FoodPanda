// lib/Widgets/CustomHeader.dart
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black), // Changed to menu icon
        onPressed: () {
          Scaffold.of(context).openDrawer();   // Drawer open
        },
      ),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Agar aapke paas foodpanda.png hai to yeh use karein
          // Image.asset(
          //   "assets/images/food.png", // foodpanda logo
          //   height: 30,
          // ),
          // const SizedBox(width: 8),
          const Text(
            "food",
            style: TextStyle(
              color: Color(0xffE5007D), // pinkish
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Text(
            "panda",
            style: TextStyle(
              color: Color(0xff212121), // dark grey
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}