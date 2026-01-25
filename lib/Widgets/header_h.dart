import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.person_outline, color: Colors.black),
        onPressed: () {
          Scaffold.of(context).openDrawer();   // Drawer open
        },
      ),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/foodpanda.png",
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            "foodpanda",
            style: TextStyle(
              color: Color(0xffE5007D), // pinkish
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
