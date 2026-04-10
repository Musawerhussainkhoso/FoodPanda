import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';

/// Pink app bar with a always-visible white back control. If the route
/// cannot pop (e.g. deep link), navigates to [fallbackRoute] or `/home`.
class FoodExpressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodExpressAppBar({
    super.key,
    required this.title,
    this.actions,
    this.fallbackRoute = '/home',
  }) : customTitle = null;

  /// Use [customTitle] instead of [Text(title)] (e.g. cart with item count).
  // ignore: prefer_const_constructors_in_immutables — [customTitle] is rarely const.
  FoodExpressAppBar.custom({
    super.key,
    required this.title,
    required this.customTitle,
    this.actions,
    this.fallbackRoute = '/home',
  });

  final String title;
  final Widget? customTitle;
  final List<Widget>? actions;
  final String? fallbackRoute;

  static void popOrFallback(BuildContext context, [String? route]) {
    final nav = Navigator.of(context);
    if (nav.canPop()) {
      nav.pop();
    } else if (route != null && route.isNotEmpty) {
      nav.pushReplacementNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        letterSpacing: -0.2,
      ),
      leadingWidth: 48,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => popOrFallback(context, fallbackRoute),
          borderRadius: BorderRadius.circular(24),
          child: const SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      title: customTitle ?? Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
