import 'package:flutter/material.dart';
import 'package:manuk_pos/core/theme/theme.dart';

class CommonListTileWithMenu extends StatelessWidget {
  final String title;
  final Function(String) onSelected;
  final List<String> menuItems;
  final Color? tileColor;
  final String? subtitle;

  const CommonListTileWithMenu({
    super.key,
    required this.title,
    required this.onSelected,
    this.menuItems = const ['Edit', 'Delete'],
    this.tileColor,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppTheme.backgroundPrimaryColor,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: PopupMenuButton<String>(
        onSelected: onSelected,
        itemBuilder: (context) => menuItems
            .map(
              (item) => PopupMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
      ),
    );
  }
}
