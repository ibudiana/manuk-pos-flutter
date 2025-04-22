import 'package:flutter/material.dart';
import 'package:manuk_pos/core/theme/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(title)),
      leading: Builder(
        builder: (context) => IconButton(
          color: AppTheme.fourthColor,
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
            color: AppTheme.fourthColor,
            focusColor: AppTheme.secondaryColor,
            icon: const Icon(Icons.notifications),
            onPressed: () {}),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
